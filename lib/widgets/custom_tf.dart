import 'package:flutter/material.dart';

import '../globals/styles/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  late Icon? icon;
  final String? supportingText;

  CustomTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.label,
      this.isPassword = false,
      this.icon,
      this.supportingText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hint,
          hintStyle: montserratHint.copyWith(fontSize: 15),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          label: Text(label, style: montserratAuth.copyWith(fontSize: 15)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey, width: 1))),
    );
  }
}
