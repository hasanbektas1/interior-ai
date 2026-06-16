import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class RoomTypeGridItem extends StatelessWidget {
  const RoomTypeGridItem({
    super.key,
    required this.roomType,
    required this.isSelected,
    required this.onTap,
  });

  final RoomType roomType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: context.width16,
          vertical: context.height16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.softPurpleFaint : AppColors.cloudGray,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.softPurple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              roomType.icon.path,
              width: context.width24,
              height: context.width24,
            ),
            SizedBox(width: context.width12),
            Expanded(
              child: Text(
                roomType.label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.richBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
