import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class EnterNameBottomSheet extends StatefulWidget {
  const EnterNameBottomSheet({super.key, required this.title, this.initialValue});

  final String title;
  final String? initialValue;

  static Future<String?> show(
    BuildContext context, {
    required String title,
    String? initialValue,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) =>
          EnterNameBottomSheet(title: title, initialValue: initialValue),
    );
  }

  @override
  State<EnterNameBottomSheet> createState() => _EnterNameBottomSheetState();
}

class _EnterNameBottomSheetState extends State<EnterNameBottomSheet> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  void _submit() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    Navigator.of(context).pop(value);
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.width20,
          context.height20,
          context.width20,
          context.height20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.height16),
            TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              cursorColor: AppColors.softPurple,
              style: const TextStyle(
                color: AppColors.smokyBlack,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.width16,
                  vertical: context.height16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.softPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.softPurple, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
