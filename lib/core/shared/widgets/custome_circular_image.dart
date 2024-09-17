import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../functions/helper_functions.dart';

class CustomeCircularImage extends StatelessWidget {
  const CustomeCircularImage({
    super.key,
    this.isNetworkImage = true,
    required this.imagePath,
    this.width = 56,
    this.height = 56,
    this.padding = const EdgeInsets.all(TSizes.sm),
    this.backroundColor,
    this.fit = BoxFit.cover,
    this.overlayColor,
  });
  final bool? isNetworkImage;
  final String imagePath;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backroundColor;
  final BoxFit? fit;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: isNetworkImage!
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                fit: fit,
                imageUrl: imagePath,
                // color: overlayColor!.withOpacity(0.1),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: THelperFunctions.isDarkMode(context)
                      ? TColors.white
                      : TColors.black,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            )
          : Image(
              fit: fit,
              image: AssetImage(imagePath),
              color: overlayColor,
            ),
    );
  }
}
