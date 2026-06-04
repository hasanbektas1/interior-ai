import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

enum CollectionMenuAction { download, share, delete }

abstract final class CollectionItemMenu {
  static Future<CollectionMenuAction?> show(
    BuildContext context,
    RelativeRect position,
  ) {
    return showMenu<CollectionMenuAction>(
      context: context,
      position: position,
      color: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.width16),
      ),
      items: [
        _item(
          context,
          value: CollectionMenuAction.download,
          label: AppStrings.collectionDownload,
          icon: Icons.file_download_outlined,
          color: AppColors.smokyBlack,
        ),
        const PopupMenuDivider(height: 1),
        _item(
          context,
          value: CollectionMenuAction.share,
          label: AppStrings.collectionShare,
          icon: Icons.ios_share_rounded,
          color: AppColors.smokyBlack,
        ),
        const PopupMenuDivider(height: 1),
        _item(
          context,
          value: CollectionMenuAction.delete,
          label: AppStrings.collectionDelete,
          icon: Icons.delete_outline_rounded,
          color: AppColors.jasper,
        ),
      ],
    );
  }

  static PopupMenuItem<CollectionMenuAction> _item(
    BuildContext context, {
    required CollectionMenuAction value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return PopupMenuItem<CollectionMenuAction>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: context.width64),
          Icon(icon, size: context.width24, color: color),
        ],
      ),
    );
  }
}
