import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/functions/helper_functions.dart';
import '../../../../core/shared/widgets/custome_rounded_container.dart';
import '../../data/model/address_model.dart';

class CustomeSingleAddress extends StatelessWidget {
  const CustomeSingleAddress({
    super.key,
    required this.addressModel,
    required this.onTapUpdate,
    this.onTapDelete,
  });

  final AddressModel addressModel;
  final void Function()? onTapUpdate;
  final void Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return CustomeRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: Colors.transparent,
      borderColor: dark ? TColors.darkerGrey : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtnItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: -10,
            child: IconButton(
              onPressed: onTapUpdate,
              icon: Icon(
                Iconsax.edit,
                color: dark ? TColors.light : TColors.black,
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: -10,
            child: IconButton(
              onPressed: onTapDelete,
              icon: Icon(
                Icons.remove_circle_outline,
                color: dark ? TColors.light : TColors.black,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.sm / 2),
              Text(
                addressModel.phone,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: TSizes.sm / 2),
              Text(
                addressModel.country,
                softWrap: true,
              ),
              const SizedBox(height: TSizes.sm / 2),
              Text(
                "${addressModel.state} - ${addressModel.city}",
                softWrap: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
