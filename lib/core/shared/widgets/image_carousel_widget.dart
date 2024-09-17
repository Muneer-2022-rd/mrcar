import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../functions/helper_functions.dart';

class ImageCarosulWidget extends StatelessWidget {
  const ImageCarosulWidget({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.padding,
    required this.applyImageRadius,
    required this.borderRadius,
    required this.border,
    required this.backgroundColor,
    required this.isNetworkImage,
    required this.imagePath,
    required this.fit,
  });

  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool applyImageRadius;
  final double borderRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final bool isNetworkImage;
  final String imagePath;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          border: border,
          color: backgroundColor,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: fit,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
                    highlightColor:
                        dark ? Colors.grey[700]! : Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                )
              : Image.asset(
                  imagePath,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}
