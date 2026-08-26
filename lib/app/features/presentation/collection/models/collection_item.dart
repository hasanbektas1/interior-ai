import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';

final class CollectionItem extends Equatable {
  final String id;
  final String title;
  final CollectionCategory category;
  final String dateLabel;
  final int createdAt;

  /// Asset path (`assets/...`) or a device file path. Rendered via `AppPhoto`.
  final String imagePath;
  final bool isGenerating;
  final RoomType? roomType;
  final String styleLabel;
  final String? prompt;

  const CollectionItem({
    required this.id,
    required this.title,
    required this.category,
    required this.dateLabel,
    required this.createdAt,
    required this.imagePath,
    required this.styleLabel,
    this.isGenerating = false,
    this.roomType,
    this.prompt,
  });

  CollectionItem copyWith({
    String? title,
    CollectionCategory? category,
    String? dateLabel,
    int? createdAt,
    String? imagePath,
    bool? isGenerating,
    RoomType? roomType,
    String? styleLabel,
    String? prompt,
  }) {
    return CollectionItem(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      dateLabel: dateLabel ?? this.dateLabel,
      createdAt: createdAt ?? this.createdAt,
      imagePath: imagePath ?? this.imagePath,
      isGenerating: isGenerating ?? this.isGenerating,
      roomType: roomType ?? this.roomType,
      styleLabel: styleLabel ?? this.styleLabel,
      prompt: prompt ?? this.prompt,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'category': category.name,
    'dateLabel': dateLabel,
    'createdAt': createdAt,
    'imagePath': imagePath,
    'isGenerating': isGenerating,
    'roomType': roomType?.name,
    'styleLabel': styleLabel,
    'prompt': prompt,
  };

  factory CollectionItem.fromMap(Map<dynamic, dynamic> map) {
    final roomTypeName = map['roomType'] as String?;
    return CollectionItem(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      category: CollectionCategory.fromName(map['category'] as String? ?? ''),
      dateLabel: map['dateLabel'] as String? ?? '',
      createdAt: map['createdAt'] as int? ?? 0,
      imagePath: map['imagePath'] as String? ?? '',
      isGenerating: map['isGenerating'] as bool? ?? false,
      roomType: roomTypeName == null
          ? null
          : RoomType.values.firstWhere(
              (type) => type.name == roomTypeName,
              orElse: () => RoomType.other,
            ),
      styleLabel: map['styleLabel'] as String? ?? '',
      prompt: map['prompt'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    dateLabel,
    createdAt,
    imagePath,
    isGenerating,
    roomType,
    styleLabel,
    prompt,
  ];
}
