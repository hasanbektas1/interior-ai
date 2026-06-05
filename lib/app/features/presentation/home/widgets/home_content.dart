import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/view/exterior_design_view.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/view/floor_restyle_view.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/garden_design/view/garden_design_view.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/home_card.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/interior_design_view.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_cubit.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/view/replace_objects_view.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_cubit.dart';
import 'package:interior_ai/app/features/presentation/style_reference/view/style_reference_view.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        context.width20,
        context.height8,
        context.width20,
        context.height24,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tileWidth = (constraints.maxWidth - context.width12) / 2;
          final tileHeight = tileWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: context.height240,
                child: HomeCard(
                  image: AppAsset.homeInteriorDesign,
                  onTap: () {
                    context.read<InteriorDesignCubit>().reset();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const InteriorDesignView(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: context.height12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight,
                    child: HomeCard(
                      image: AppAsset.homeExteriorDesign,
                      onTap: () {
                        context.read<ExteriorDesignCubit>().reset();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ExteriorDesignView(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: context.width12),
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight,
                    child: HomeCard(
                      image: AppAsset.homeReplaceObjects,
                      onTap: () {
                        context.read<ReplaceObjectsCubit>().reset();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ReplaceObjectsView(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.height12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: Column(
                      children: [
                        SizedBox(
                          height: tileHeight,
                          child: HomeCard(
                            image: AppAsset.homeFloorRestyle,
                            onTap: () {
                              context.read<FloorRestyleCubit>().reset();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const FloorRestyleView(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: context.height12),
                        SizedBox(
                          height: tileHeight,
                          child: HomeCard(
                            image: AppAsset.homeGardenDesign,
                            onTap: () {
                              context.read<GardenDesignCubit>().reset();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const GardenDesignView(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.width12),
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight * 2 + context.height12,
                    child: HomeCard(
                      image: AppAsset.homeStyleReference,
                      onTap: () {
                        context.read<StyleReferenceCubit>().reset();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const StyleReferenceView(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
