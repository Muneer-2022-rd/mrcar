import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Onboarding3dModelWidget extends StatefulWidget {
  const Onboarding3dModelWidget({
    super.key,
    required this.model3D,
  });

  final String model3D;

  @override
  State<Onboarding3dModelWidget> createState() =>
      _Onboarding3dModelWidgetState();
}

class _Onboarding3dModelWidgetState extends State<Onboarding3dModelWidget> {
  late Flutter3DController controller;
  @override
  void initState() {
    super.initState();
    controller = Flutter3DController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Flutter3DViewer(
        progressBarColor: Theme.of(context).primaryColor,
        controller: controller,
        src: widget.model3D,
      ),
    );
  }
}