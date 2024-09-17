import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/shared/widgets/custome_rounded_container.dart';
import '../../../../address/data/model/address_model.dart';

class TSingleSelectionAddress extends StatelessWidget {
  const TSingleSelectionAddress({
    super.key,
    required this.addressModel,
    required this.containerColor,
    required this.textColor,
    this.onTap,
  });

  final AddressModel addressModel;
  final Color containerColor;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: CustomeRoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        width: double.infinity,
        showBorder: true,
        backgroundColor: containerColor,
        borderColor: dark ? TColors.darkerGrey : TColors.grey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtnItems),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addressModel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: textColor),
                ),
                const SizedBox(height: TSizes.sm / 2),
                Text(
                  addressModel.phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: textColor),
                ),
                const SizedBox(height: TSizes.sm / 2),
                Text(
                  addressModel.country,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: textColor),
                ),
                const SizedBox(height: TSizes.sm / 2),
                Text(
                  "${addressModel.state} - ${addressModel.city}",
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: textColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
