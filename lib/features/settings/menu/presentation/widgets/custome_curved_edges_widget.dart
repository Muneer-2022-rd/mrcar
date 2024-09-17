import 'package:flutter/material.dart';
import 'custome_clipper.dart';
class CustomeCurvedEdgesWidget extends StatelessWidget {
  const CustomeCurvedEdgesWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomeCurvedEdges(),
      child: child,
    );
  }
}