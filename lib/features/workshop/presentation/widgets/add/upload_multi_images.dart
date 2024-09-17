import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constants/sizes.dart';

class UploadMultiImages extends StatefulWidget {
  final List<File>? images;
  final void Function()? uploadImages;
  const UploadMultiImages({
    super.key,
    required this.images,
    this.uploadImages,
  });

  @override
  State<UploadMultiImages> createState() => _UploadMultiImagesState();
}

class _UploadMultiImagesState extends State<UploadMultiImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.images!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: TSizes.spaceBtnItems),
                  Text(
                    'New Images',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(fontSizeDelta: 8),
                  ),
                  const SizedBox(height: TSizes.spaceBtnItems),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.images!.map((image) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.images!.remove(image);
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(height: TSizes.spaceBtnItems),
        ElevatedButton(
          style: ButtonStyle(
            side: MaterialStatePropertyAll(
              BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            foregroundColor: const MaterialStatePropertyAll(
              Colors.black,
            ),
            backgroundColor: MaterialStatePropertyAll(
              Colors.grey.withOpacity(0.2),
            ),
          ),
          onPressed: widget.uploadImages,
          child: const Text('Upload Others Images'),
        ),
      ],
    );
  }
}
