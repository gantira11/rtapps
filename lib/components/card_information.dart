import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({
    Key? key,
    required this.titleCard,
    required this.bodyCard,
    required this.imgCard,
  }) : super(key: key);

  final String titleCard;
  final String bodyCard;
  final String imgCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 2,
      child: SizedBox(
        width: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                imgCard,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 1,
                bottom: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    titleCard,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bodyCard,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
