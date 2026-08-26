import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/widgets/buttons/gradient_button.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/extensions/widgets/padding_extensions.dart';

class ExamplePhotosSheet extends StatefulWidget {
  const ExamplePhotosSheet({super.key, required this.photos});

  final List<AppAsset> photos;

  static Future<AppAsset?> show(BuildContext context, List<AppAsset> photos) {
    return showModalBottomSheet<AppAsset>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.ghostWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ExamplePhotosSheet(photos: photos),
    );
  }

  @override
  State<ExamplePhotosSheet> createState() => _ExamplePhotosSheetState();
}

class _ExamplePhotosSheetState extends State<ExamplePhotosSheet> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.85,
      child: Column(
        children: [
          SizedBox(
            height: context.height44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  AppStrings.replaceExamplePhotosTitle,
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
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Icon(
                      Icons.close_rounded,
                      size: context.width24,
                      color: AppColors.smokyBlack,
                    ),
                  ),
                ).onlyPadding(right: context.width20),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: context.width20,
                vertical: context.height12,
              ),
              itemCount: widget.photos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: context.width12,
                mainAxisSpacing: context.height12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final bool isSelected = _selectedIndex == index;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.width16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.softPurple
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(context.width12),
                      child: Image.asset(
                        widget.photos[index].path,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const ColoredBox(color: AppColors.magnolia),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.width20,
              context.height8,
              context.width20,
              context.height24,
            ),
            child: GradientButton(
              text: AppStrings.interiorDone,
              onPressed: _selectedIndex == null
                  ? null
                  : () => Navigator.of(
                      context,
                    ).pop(widget.photos[_selectedIndex!]),
            ),
          ),
        ],
      ),
    );
  }
}
