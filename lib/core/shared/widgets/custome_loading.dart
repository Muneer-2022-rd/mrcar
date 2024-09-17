import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  const LoadingWidget({super.key, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 50,
        height: height ?? 50,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
