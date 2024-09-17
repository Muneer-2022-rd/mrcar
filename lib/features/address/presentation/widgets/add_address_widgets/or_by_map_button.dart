import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/images.dart';
import '../../../../../core/shared/widgets/custome_rounded_container.dart';
import '../../../../../core/shared/widgets/custome_rounded_image.dart';
import '../../../data/local/address_local.dart';

class OrByMapButton extends StatelessWidget {
  const OrByMapButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomeRoundedImage(
          imagePath: TImages.map,
          type: 'image',
          isNetworkImage: false,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        CustomeRoundedContainer(
          height: 150,
          width: double.infinity,
          backgroundColor: Colors.transparent,
          child: Center(
            child: CustomeRoundedContainer(
              backgroundColor: Colors.white.withOpacity(0.7),
              padding: const EdgeInsets.all(10),
              child: Text(
                AddressConstant.addressOrByMap.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
