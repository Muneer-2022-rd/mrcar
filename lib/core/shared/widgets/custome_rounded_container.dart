import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';

class CustomeRoundedContainer extends StatelessWidget {
  const CustomeRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.raduis = TSizes.cardRadiusLg,
    this.padding,
    this.margin,
    this.child,
    this.backgroundColor = TColors.white,
    this.borderColor = TColors.borderPrimary,
    this.showBorder = false,
    this.animated = false,
  });
  final double? width;
  final double? height;
  final double raduis;
  final EdgeInsets? padding;
  final Color borderColor;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;
  final bool showBorder;
  final bool? animated;

  @override
  Widget build(BuildContext context) {
    return animated!
        ? AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(raduis),
              color: backgroundColor,
              border: showBorder ? Border.all(color: borderColor) : null,
            ),
            child: child,
          )
        : Container(
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(raduis),
              color: backgroundColor,
              border: showBorder ? Border.all(color: borderColor) : null,
            ),
            child: child,
          );
  }
}
