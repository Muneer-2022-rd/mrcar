import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.validator,
  });
  final String labelText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        label: Text(labelText),
      ),
      style: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: TColors.black,
        fontFamily: 'Poppins',
      ),
    );
  }
}
