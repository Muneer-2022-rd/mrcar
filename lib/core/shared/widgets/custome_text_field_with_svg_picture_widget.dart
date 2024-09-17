import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomeTextFieldWithSvgPictureWidget extends StatelessWidget {
  CustomeTextFieldWithSvgPictureWidget({
    super.key,
    required this.controller,
    required this.imagePath,
    required this.label,
    required this.keyboardType,
    this.enabled = true,
    this.validator,
    this.color,
  });

  final TextEditingController controller;
  final String imagePath;
  final String label;
  final TextInputType keyboardType;
  bool? enabled;
  final String? Function(String?)? validator;
  Color? color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        suffixIconConstraints: const BoxConstraints(minWidth: 50, maxWidth: 50),
        suffixIcon: imagePath != null || imagePath != ''
            ? SizedBox(
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  color: color,
                ),
              )
            : null,
      ),
    );
  }
}
