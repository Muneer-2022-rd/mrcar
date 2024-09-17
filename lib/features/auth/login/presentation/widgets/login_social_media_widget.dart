import 'package:cars_equipments_shop/core/functions/navigation.dart';
import 'package:cars_equipments_shop/core/shared/data/local/shared_local.dart';
import 'package:cars_equipments_shop/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/sizes.dart';
import '../../data/local/login_local.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Divider(
                color: TColors.black,
                thickness: 0.5,
                indent: 60,
                endIndent: 5,
              ),
            ),
            Text(
              LoginConstants.loginFormOr.tr(context),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Flexible(
              child: Divider(
                color: TColors.black,
                thickness: 0.5,
                indent: 5,
                endIndent: 60,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  pushNamed(context, PagesName.byPhone);
                },
                icon: const Icon(Iconsax.call),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtnItems),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(GoogleSignInEvent());
                },
                icon: const Image(
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                  image: AssetImage(TImages.google),
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtnItems),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: TColors.grey),
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                onPressed: () {},
                icon: const Image(
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                  image: AssetImage(TImages.facebook),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
