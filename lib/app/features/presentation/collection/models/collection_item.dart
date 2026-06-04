import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';

final class CollectionItem extends Equatable {
  final String id;
  final String title;
  final CollectionCategory category;
  final String dateLabel;
  final AppAsset image;
  final bool isGenerating;
  final RoomType roomType;
  final String styleLabel;
  final String? prompt;

  const CollectionItem({
    required this.id,
    required this.title,
    required this.category,
    required this.dateLabel,
    required this.image,
    required this.roomType,
    required this.styleLabel,
    this.isGenerating = false,
    this.prompt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        dateLabel,
        image,
        isGenerating,
        roomType,
        styleLabel,
        prompt,
      ];
}
