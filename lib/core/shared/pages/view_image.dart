import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({
    super.key,
    this.networkImage,
    this.storageImage,
    required this.isNetwork,
  });
  final String? networkImage;
  final File? storageImage;
  final bool? isNetwork;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              child: isNetwork!
                  ? Image.network(networkImage!)
                  : Image.file(storageImage!),
            ),
            Positioned(
              top: 20,
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: TColors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: TColors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
