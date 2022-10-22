import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';

class TextInputSuffix extends StatelessWidget {
  const TextInputSuffix({
    Key? key,
    required this.labelText,
    required this.iconData,
    required this.onTap,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    this.validator,
  }) : super(key: key);

  final String labelText;
  final IconData iconData;
  final VoidCallback onTap;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: baseContentColor,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: const TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: baseContentColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: baseContentColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: baseContentColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(
            iconData,
            color: baseContentColor,
            size: 22,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryFocusColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(color: secondaryFocusColor),
        focusColor: baseContentColor,
        // filled: true,
        isDense: true,
      ),
    );
  }
}
