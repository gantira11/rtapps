import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';

class TextInputDefault extends StatelessWidget {
  const TextInputDefault({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    this.validator,
    this.maxLength,
    this.enabled,
    this.maxLine,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool? enabled;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLength: maxLength,
      maxLines: maxLine,
      style: const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: baseContentColor,
      ),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: const TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: baseContentColor,
        ),
        counterText: '',
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
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
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

        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: baseContentColor,
            width: 0.5,
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
