import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';

class StrukturPengurusScreen extends StatefulWidget {
  const StrukturPengurusScreen({Key? key}) : super(key: key);

  @override
  State<StrukturPengurusScreen> createState() => _StrukturPengurusScreenState();
}

class _StrukturPengurusScreenState extends State<StrukturPengurusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
          ),
        ),
        backgroundColor: primaryColor,
        title: const Text(
          'Struktur Masjid',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/StrukturRT.png',
        ),
      ),
    );
  }
}
