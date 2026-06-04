import 'package:equatable/equatable.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';

final class CollectionState extends Equatable {
  final List<CollectionItem> items;
  final CollectionCategory? filter;

  const CollectionState({this.items = const [], this.filter});

  CollectionState copyWith({
    List<CollectionItem>? items,
    CollectionCategory? filter,
    bool clearFilter = false,
  }) {
    return CollectionState(
      items: items ?? this.items,
      filter: clearFilter ? null : (filter ?? this.filter),
    );
  }

  List<CollectionItem> get visibleItems => filter == null
      ? items
      : items.where((item) => item.category == filter).toList();

  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items, filter];
}
