import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/shared/widgets/custome_shimmer_effect.dart';

class ListViewShimmerLayoutShops extends StatelessWidget {
  const ListViewShimmerLayoutShops({
    super.key,
    this.itemCount,
    required this.scrollDirection,
    required this.width,
  });

  final int? itemCount;
  final Axis scrollDirection;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomeShimmerEffect(height: 200, width: width!),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: TSizes.spaceBtnItems / 2),
                    CustomeShimmerEffect(height: 15, width: 140),
                    SizedBox(height: TSizes.spaceBtnItems / 2),
                    CustomeShimmerEffect(height: 15, width: 70),
                  ],
                ),
                CustomeShimmerEffect(height: 15, width: 40),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtnItems),
          ],
        );
      },
    );
  }
}
