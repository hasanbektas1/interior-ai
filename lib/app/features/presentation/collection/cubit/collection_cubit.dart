import 'package:bloc/bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:interior_ai/app/features/presentation/collection/enums/collection_category.dart';
import 'package:interior_ai/app/features/presentation/collection/models/collection_item.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';

final class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionState(items: _seed));

  static const List<CollectionItem> _seed = [
    CollectionItem(
      id: '0',
      title: 'Interior Design #2',
      category: CollectionCategory.interiorDesign,
      dateLabel: '',
      image: AppAsset.onboardingSelectLivingRoom,
      isGenerating: true,
      roomType: RoomType.livingRoom,
      styleLabel: 'Modern',
    ),
    CollectionItem(
      id: '1',
      title: 'Paint Project #1',
      category: CollectionCategory.paint,
      dateLabel: '25 April 2025, 2:18 AM',
      image: AppAsset.onboardingSelectDiningRoom,
      roomType: RoomType.diningRoom,
      styleLabel: 'Bohemian',
    ),
    CollectionItem(
      id: '2',
      title: 'Style Reference #1',
      category: CollectionCategory.styleReference,
      dateLabel: '25 April 2025, 7:52 AM',
      image: AppAsset.onboardingSelectWorkspace,
      roomType: RoomType.studyRoom,
      styleLabel: 'Minimalistic',
    ),
    CollectionItem(
      id: '3',
      title: 'Replace Object #1',
      category: CollectionCategory.replaceObject,
      dateLabel: '24 April 2025, 9:46 PM',
      image: AppAsset.onboardingSelectArmchair,
      roomType: RoomType.livingRoom,
      styleLabel: 'Rustic',
    ),
    CollectionItem(
      id: '4',
      title: 'Interior Design #1',
      category: CollectionCategory.interiorDesign,
      dateLabel: '23 April 2025, 10:15 PM',
      image: AppAsset.onboardingSelectBedroom,
      roomType: RoomType.livingRoom,
      styleLabel: 'Custom',
      prompt:
          'Modern Scandinavian living room with natural light, light wood furniture, and cozy textures',
    ),
  ];

  void selectFilter(CollectionCategory? category) {
    if (category == null) {
      emit(state.copyWith(clearFilter: true));
      return;
    }
    emit(state.copyWith(filter: category));
  }

  void addItem(CollectionItem item) {
    emit(state.copyWith(items: [item, ...state.items]));
  }

  void deleteItem(String id) {
    emit(
      state.copyWith(
        items: state.items.where((item) => item.id != id).toList(),
      ),
    );
  }
}
