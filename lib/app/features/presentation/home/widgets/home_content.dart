import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/features/presentation/home/widgets/home_card.dart';
import 'package:interior_ai/app/features/presentation/interior_design/view/interior_design_view.dart';
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const InteriorDesignView(),
                    ),
                  ),
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
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: context.width12),
                  SizedBox(
                    width: tileWidth,
                    height: tileHeight,
                    child: HomeCard(
                      image: AppAsset.homeReplaceObjects,
                      onTap: () {},
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
                            onTap: () {},
                          ),
                        ),
                        SizedBox(height: context.height12),
                        SizedBox(
                          height: tileHeight,
                          child: HomeCard(
                            image: AppAsset.homeGardenDesign,
                            onTap: () {},
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
                      onTap: () {},
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
