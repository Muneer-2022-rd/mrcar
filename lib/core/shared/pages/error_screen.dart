import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/images.dart';
import '../../functions/helper_functions.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              // registerBloc.add(NavigateToLoginEvent());
            },
            icon: const Icon(Icons.clear),
          ),
        ],
        leading: const SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSizes.edgeInsets * 2,
          child: Column(
            children: [
              Lottie.asset(
                TImages.error,
                width: THelperFunctions.screenWidth(context) * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtnSections,
              ),
              Text(
                'opps_title'.tr(context),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtnItems),
              Text(
                'opps_message'.tr(context),
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtnSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'opps_btn_title'.tr(context),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtnSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
