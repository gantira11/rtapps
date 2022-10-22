import 'package:flutter/material.dart';

class StrukturMasjidScreen extends StatefulWidget {
  const StrukturMasjidScreen({Key? key}) : super(key: key);

  @override
  State<StrukturMasjidScreen> createState() => _StrukturMasjidScreenState();
}

class _StrukturMasjidScreenState extends State<StrukturMasjidScreen> {
  get primaryColor => null;

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
          'assets/images/StrukturMasjid.png',
        ),
      ),
    );
  }
}
