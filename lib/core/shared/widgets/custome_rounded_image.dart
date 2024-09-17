import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import 'image_carousel_widget.dart';
import 'video_carousel_widget.dart';

class CustomeRoundedImage extends StatelessWidget {
  const CustomeRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imagePath,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = TColors.light,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
    required this.type,
  });
  final double? width, height;
  final String imagePath;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final String type;

  @override
  Widget build(BuildContext context) {
    return type == "image"
        ? ImageCarosulWidget(
            onPressed: onPressed,
            width: width,
            height: height,
            padding: padding,
            applyImageRadius: applyImageRadius,
            borderRadius: borderRadius,
            border: border,
            backgroundColor: backgroundColor,
            isNetworkImage: isNetworkImage,
            imagePath: imagePath,
            fit: fit,
          )
        : VideoCarouselWidget(
            videoPath: imagePath,
            width: width,
            height: height,
            padding: padding,
            applyImageRadius: applyImageRadius,
            borderRadius: borderRadius,
          );
  }
}
