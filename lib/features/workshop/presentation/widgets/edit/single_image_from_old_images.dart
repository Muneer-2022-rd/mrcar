import 'package:flutter/material.dart';

class SingleImage extends StatefulWidget {
  final String image;
  final void Function()? onPressed;
  const SingleImage({
    super.key,
    required this.image,
    required this.onPressed,
  });

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
