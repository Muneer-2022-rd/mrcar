import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/sizes.dart';
import '../../data/local/login_local.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: MediaQuery.of(context).size.height * 0.3,
          image: const AssetImage(TImages.lightAppLogo),
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        Text(
          LoginConstants.loginTitle.tr(context),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        Text(
          LoginConstants.loginSubtitle.tr(context),
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
      ],
    );
  }
}