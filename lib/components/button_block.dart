import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';

class ButtonBlock extends StatelessWidget {
  const ButtonBlock({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.color = primaryColor,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 5,
        fixedSize: Size(size.width * 1, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          letterSpacing: 1,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
