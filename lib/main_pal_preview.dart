import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_theme_data.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/design_style.dart';
import 'package:interior_ai/app/features/presentation/interior_design/enums/room_type.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/interior_design_view.dart';
import 'package:interior_ai/app/features/presentation/interior_design/widgets/custom_style_bottom_sheet.dart';

const String kMode = String.fromEnvironment('MODE', defaultValue: 'palette');

void main() {
  final cubit = InteriorDesignCubit()
    ..selectExample(0)
    ..next()
    ..selectRoomType(RoomType.livingRoom)
    ..next();
  if (kMode == 'palette') {
    cubit
      ..selectStyle(DesignStyle.modern)
      ..next();
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.themeData,
      home: BlocProvider<InteriorDesignCubit>.value(
        value: cubit,
        child: _Harness(rate: kMode == 'custom'),
      ),
    ),
  );
}

class _Harness extends StatefulWidget {
  const _Harness({required this.rate});
  final bool rate;
  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> {
  @override
  void initState() {
    super.initState();
    if (widget.rate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomStyleBottomSheet.show(
          context,
          initialPrompt:
              'Modern Scandinavian living room with natural light, light wood furniture, and cozy textures',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) => const InteriorDesignView();
}
