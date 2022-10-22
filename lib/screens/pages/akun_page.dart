// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rtapp/components/button_block.dart';
import 'package:rtapp/components/content_data_diri.dart';
import 'package:rtapp/constants.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> dataUser = {};

  Future<void> fetchUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user?.uid).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            dataUser = documentSnapshot.data() as Map<String, dynamic>;
          });
        } else {
          print('Document Tidak ditemukan');
        }
      },
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      'login',
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          'Akun saya',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: baseContentColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data Diri',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ContentDataDiri(
                          icon: Icons.credit_card,
                          textContent: dataUser.isEmpty ? '' : dataUser['nik'],
                        ),
                        const SizedBox(height: 10),
                        ContentDataDiri(
                          icon: Icons.account_circle_outlined,
                          textContent:
                              dataUser.isEmpty ? '' : dataUser['nama_lengkap'],
                        ),
                        const SizedBox(height: 10),
                        ContentDataDiri(
                          icon: Icons.email_outlined,
                          textContent:
                              dataUser.isEmpty ? '' : dataUser['email'],
                        ),
                        const SizedBox(height: 10),
                        ContentDataDiri(
                          icon: Icons.phone_android_outlined,
                          textContent:
                              dataUser.isEmpty ? '' : dataUser['phone'],
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Pusat Bantuan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonBlock(
          buttonText: 'Logout',
          color: secondaryColor,
          onPressed: () {
            _logout();
          },
        ),
      ),
    );
  }
}
