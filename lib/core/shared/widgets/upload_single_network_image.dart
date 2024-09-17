import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_equipments_shop/core/shared/widgets/custome_shimmer_effect.dart';
import 'package:flutter/material.dart';

class UploadSingleNetworkImage extends StatelessWidget {
  final String? thmbnail;
  final File? file;
  final void Function()? onTap;

  final String? title;
  const UploadSingleNetworkImage({
    super.key,
    required this.thmbnail,
    this.onTap,
    required this.title,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    return file != null
        ? GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  file!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : thmbnail != null
            ? GestureDetector(
                onTap: onTap,
                child: SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: thmbnail!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CustomeShimmerEffect(
                        width: double.infinity,
                        height: 150,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
  }
}
