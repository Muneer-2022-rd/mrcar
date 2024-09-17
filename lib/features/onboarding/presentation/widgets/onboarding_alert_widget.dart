import 'package:cars_equipments_shop/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class OnBoardingAlertWidget extends StatelessWidget {
  const OnBoardingAlertWidget({
    super.key,
    required this.alert,
  });
  final String alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
      ),
      child: Text(
        alert,
        style: const TextStyle(color: Colors.white, fontSize: TSizes.fontSizeMd),
        textAlign: TextAlign.center,
      ),
    );
  }
}
