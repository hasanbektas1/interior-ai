import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_state.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/enter_name_bottom_sheet.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/room_type_grid_item.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class RoomTypeStep extends StatelessWidget {
  const RoomTypeStep({super.key, required this.state});

  final InteriorDesignState state;

  Future<void> _onSelect(BuildContext context, RoomType roomType) async {
    final cubit = context.read<InteriorDesignCubit>();
    cubit.selectRoomType(roomType);
    if (roomType != RoomType.other) return;
    final name = await EnterNameBottomSheet.show(
      context,
      title: AppStrings.interiorEnterStyleName,
      initialValue: state.customRoomName,
    );
    if (name != null) cubit.setCustomRoomName(name);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: context.height16, bottom: context.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.interiorChooseRoomTypeTitle,
            style: TextStyle(
              color: AppColors.richBlack,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.height4),
          const Text(
            AppStrings.interiorChooseRoomTypeSubtitle,
            style: TextStyle(
              color: AppColors.richBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: context.height20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: RoomType.values.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.width12,
              mainAxisSpacing: context.height12,
              mainAxisExtent: context.height58,
            ),
            itemBuilder: (context, index) {
              final roomType = RoomType.values[index];
              return RoomTypeGridItem(
                roomType: roomType,
                isSelected: state.roomType == roomType,
                onTap: () => _onSelect(context, roomType),
              );
            },
          ),
        ],
      ),
    );
  }
}
