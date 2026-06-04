import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/buttons/app_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class CustomStyleBottomSheet extends StatefulWidget {
  const CustomStyleBottomSheet({super.key, this.initialPrompt});

  final String? initialPrompt;

  static Future<String?> show(BuildContext context, {String? initialPrompt}) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CustomStyleBottomSheet(initialPrompt: initialPrompt),
    );
  }

  @override
  State<CustomStyleBottomSheet> createState() => _CustomStyleBottomSheetState();
}

class _CustomStyleBottomSheetState extends State<CustomStyleBottomSheet> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialPrompt);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  bool get _canSave => _controller.text.trim().isNotEmpty;

  void _selectPrompt(String prompt) {
    _controller.text = prompt;
    FocusScope.of(context).unfocus();
  }

  void _save() {
    if (!_canSave) return;
    Navigator.of(context).pop(_controller.text.trim());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
      child: SizedBox(
        height: context.height * 0.9,
        child: Column(
          children: [
            _Header(onClose: () => Navigator.of(context).maybePop()),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  context.width20,
                  context.height16,
                  context.width20,
                  context.height16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PromptField(controller: _controller),
                    SizedBox(height: context.height24),
                    const Text(
                      AppStrings.interiorPromptLibrary,
                      style: TextStyle(
                        color: AppColors.smokyBlack,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: context.height12),
                    for (final prompt in AppStrings.interiorPromptLibraryItems)
                      Padding(
                        padding: EdgeInsets.only(bottom: context.height10),
                        child: _PromptLibraryItem(
                          prompt: prompt,
                          isSelected: _controller.text.trim() == prompt,
                          onTap: () => _selectPrompt(prompt),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.width20,
                context.height8,
                context.width20,
                context.height20,
              ),
              child: AppButton.fill(
                text: AppStrings.interiorSave,
                onPressed: _canSave ? _save : null,
                backgroundColor: AppColors.softPurple,
                disabledBackgroundColor: AppColors.disabledGray,
                disabledTextColor: AppColors.disabledText,
                borderRadius: 14,
                height: 54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.width20,
        context.height16,
        context.width20,
        context.height8,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            AppStrings.interiorCustomStyleTitle,
            style: TextStyle(
              color: AppColors.smokyBlack,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onClose,
              child: Icon(
                Icons.close_rounded,
                size: context.width24,
                color: AppColors.smokyBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromptField extends StatelessWidget {
  const _PromptField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      minLines: 5,
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
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.softPurple, width: 2),
        ),
      ),
    );
  }
}

class _PromptLibraryItem extends StatelessWidget {
  const _PromptLibraryItem({
    required this.prompt,
    required this.isSelected,
    required this.onTap,
  });

  final String prompt;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.width16,
          vertical: context.height16,
        ),
        decoration: BoxDecoration(
          color: AppColors.cloudGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.softPurple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          prompt,
          style: const TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
