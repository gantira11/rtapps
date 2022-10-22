import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';

class ContentDataDiri extends StatelessWidget {
  const ContentDataDiri({
    Key? key,
    required this.textContent,
    required this.icon,
  }) : super(key: key);

  final String textContent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 24,
          color: baseContentColor,
        ),
        const SizedBox(width: 10),
        Text(
          textContent,
          style: const TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
