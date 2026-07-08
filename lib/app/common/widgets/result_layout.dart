import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/app_photo.dart';
import 'package:interior_ai/app/common/widgets/result_header.dart';
import 'package:interior_ai/app/common/widgets/result_prompt_section.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

/// Shared scaffold for every result screen.
///
/// Layout rules enforced here so all features stay consistent:
/// * the image sits 24px below the header, matching the 24px side padding;
/// * the image expands to fill whatever space the (optional) prompt and
///   details leave, so short content never leaves an empty gap;
/// * the prompt caps at three lines and scrolls internally.
class ResultLayout extends StatelessWidget {
  const ResultLayout({
    super.key,
    required this.imagePath,
    required this.footer,
    required this.onClose,
    this.title = AppStrings.interiorResultHeader,
    this.onShare,
    this.prompt,
    this.details,
  });

  final String imagePath;
  final Widget footer;
  final VoidCallback onClose;
  final String title;
  final VoidCallback? onShare;
  final String? prompt;

  /// Feature-specific content shown under the image (chips, segment, variant
  /// strip …). Each feature keeps its own result content here.
  final Widget? details;

  @override
  Widget build(BuildContext context) {
    final bool hasPrompt = prompt?.isNotEmpty ?? false;
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            ResultHeader(title: title, onShare: onShare, onClose: onClose),
            SizedBox(height: context.height24),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width16),
                child: SizedBox(
                  width: double.infinity,
                  child: AppPhoto(path: imagePath),
                ),
              ),
            ),
            if (hasPrompt) ...[
              SizedBox(height: context.height20),
              ResultPromptSection(prompt: prompt!),
            ],
            if (details != null) ...[
              SizedBox(height: hasPrompt ? context.height12 : context.height20),
              details!,
            ],
            SizedBox(height: context.height20),
            footer,
            SizedBox(height: context.height16),
          ],
        ).symmetricPadding(horizontal: context.width24),
      ),
    );
  }
}
