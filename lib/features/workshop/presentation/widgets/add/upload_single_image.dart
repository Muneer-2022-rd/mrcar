import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UploadSingleImage extends StatelessWidget {
  final File? thmbnail;
  final void Function()? uploadImage;
  final void Function()? deleteImage;
  final String? title;
  const UploadSingleImage({
    super.key,
    required this.thmbnail,
    this.uploadImage,
    this.deleteImage, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return thmbnail != null
        ? Stack(
            children: [
              GestureDetector(
                onTap: uploadImage,
                child: SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      thmbnail!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15.0,
                right: 15.0,
                child: IconButton(
                  onPressed: deleteImage,
                  icon: const Icon(Iconsax.trash),
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: uploadImage,
            child: DottedBorder(
              color: Colors.grey,
              dashPattern: const [10, 4],
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open,
                      size: 40,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Select $title Image',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
