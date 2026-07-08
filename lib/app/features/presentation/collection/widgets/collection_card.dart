import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/widgets/app_photo.dart';
import 'package:interior_ai/app/common/widgets/gradient_progress_ring.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onMenu,
  });

  final CollectionItem item;
  final VoidCallback onTap;
  final ValueChanged<RelativeRect> onMenu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: item.isGenerating ? null : onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.width8),
        child: SizedBox(
          width: double.infinity,
          height: context.height200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppPhoto(path: item.imagePath),
              if (item.isGenerating)
                _GeneratingOverlay()
              else ...[
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.smokyBlack.withValues(alpha: 0.55),
                          ],
                          stops: const [0.45, 1],
                        ),
                      ),
                    ),
                  ),
                ),
                _BottomInfo(title: item.title, date: item.dateLabel),
                Positioned(
                  top: context.height12,
                  right: context.width12,
                  child: _MenuButton(onTap: onMenu),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GeneratingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
        color: AppColors.smokyBlack.withValues(alpha: 0.2),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientProgressRing(size: context.width44, strokeWidth: 4),
            SizedBox(height: context.height12),
            const Text(
              AppStrings.collectionGenerating,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomInfo extends StatelessWidget {
  const _BottomInfo({required this.title, required this.date});

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width16,
          vertical: context.height12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.height4),
            Text(
              date,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.onTap});

  final ValueChanged<RelativeRect> onTap;

  void _handleTap(BuildContext context) {
    final button = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    onTap(position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleTap(context),
      child: Container(
        width: context.width32,
        height: context.width32,
        decoration: BoxDecoration(
          color: AppColors.smokyBlack.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.more_horiz_rounded,
          size: context.width20,
          color: AppColors.white,
        ),
      ),
    );
  }
}
