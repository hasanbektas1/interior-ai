import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/app/common/widgets/buttons/gradient_button.dart';
import 'package:interior_ai/app/common/widgets/dialogs/add_photo_bottom_sheet.dart';
import 'package:interior_ai/app/common/widgets/dialogs/remove_photo_dialog.dart';
import 'package:interior_ai/app/common/widgets/example_photos_sheet.dart';
import 'package:interior_ai/app/common/widgets/gem_header.dart';
import 'package:interior_ai/app/common/widgets/generated_error_view.dart';
import 'package:interior_ai/app/common/widgets/generated_processing_view.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_cubit.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_state.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/enums/replace_objects_step.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/view/replace_objects_result_view.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/widgets/brush_toolbar.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/widgets/replace_objects_photo_editor.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class ReplaceObjectsView extends StatelessWidget {
  const ReplaceObjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ReplaceObjectsBody();
  }
}

class _ReplaceObjectsBody extends StatelessWidget {
  const _ReplaceObjectsBody();

  void _exit(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplaceObjectsCubit, ReplaceObjectsState>(
      builder: (context, state) {
        final cubit = context.read<ReplaceObjectsCubit>();
        switch (state.step) {
          case ReplaceObjectsStep.processing:
            return GeneratedProcessingView(
              onBackToHome: () => _exit(context),
              onBack: () => _exit(context),
            );
          case ReplaceObjectsStep.result:
            return ReplaceObjectsResultView(
              prompt: state.prompt,
              onClose: () => _exit(context),
              onRegenerate: cubit.retry,
            );
          case ReplaceObjectsStep.error:
            return GeneratedErrorView(
              onTryAgain: cubit.retry,
              onBackToHome: () => _exit(context),
            );
          case ReplaceObjectsStep.editor:
            return _Editor(state: state);
        }
      },
    );
  }
}

class _Editor extends StatefulWidget {
  const _Editor({required this.state});

  final ReplaceObjectsState state;

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.state.prompt);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onAdd(BuildContext context) async {
    final cubit = context.read<ReplaceObjectsCubit>();
    final source = await AddPhotoBottomSheet.show(context, showExampleOption: true);
    if (source == null || !context.mounted) return;
    if (source == PhotoSource.example) {
      final picked = await ExamplePhotosSheet.show(context, kReplaceExamplePhotos);
      if (picked != null) cubit.setPhoto(picked.path);
      return;
    }
    cubit.addSamplePhoto();
  }

  Future<void> _onRemove(BuildContext context) async {
    final cubit = context.read<ReplaceObjectsCubit>();
    final shouldRemove = await RemovePhotoDialog.show(context);
    if (shouldRemove ?? false) cubit.removePhoto();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReplaceObjectsCubit>();
    final state = widget.state;
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            GemHeader(
              title: AppStrings.replaceObjects,
              onClose: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: context.height16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.height320,
                      child: ReplaceObjectsPhotoEditor(
                        photoPath: state.photoPath,
                        onAdd: () => _onAdd(context),
                        onRemove: () => _onRemove(context),
                      ),
                    ),
                    SizedBox(height: context.height16),
                    BrushToolbar(enabled: state.photoPath != null),
                    SizedBox(height: context.height16),
                    _PromptField(
                      controller: _controller,
                      onChanged: cubit.setPrompt,
                    ),
                  ],
                ),
              ),
            ),
            if (state.canGenerate)
              GradientButton(
                text: AppStrings.replaceGenerateObject,
                onPressed: cubit.generate,
              )
            else
              AppButton.fill(
                text: AppStrings.replaceGenerateObject,
                onPressed: null,
                borderRadius: 27,
                height: 54,
                disabledBackgroundColor: AppColors.disabledGray,
                disabledTextColor: AppColors.disabledText,
              ),
            SizedBox(height: context.height16),
          ],
        ).symmetricPadding(horizontal: context.width24),
      ),
    );
  }
}

class _PromptField extends StatelessWidget {
  const _PromptField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      minLines: 3,
      maxLines: 3,
      cursorColor: AppColors.softPurple,
      style: const TextStyle(
        color: AppColors.smokyBlack,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.interiorPromptHint,
        hintStyle: const TextStyle(
          color: AppColors.nickel,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.cloudGray,
        contentPadding: EdgeInsets.all(context.width16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.softPurple, width: 2),
        ),
      ),
    );
  }
}
