import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rtapp/components/card_information.dart';
import 'package:rtapp/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> _infoWarga = FirebaseFirestore.instance
      .collection('info')
      .where('jenis_info', isEqualTo: 'warga')
      .snapshots();

  final Stream<QuerySnapshot> _infoMasjid = FirebaseFirestore.instance
      .collection('info')
      .where('jenis_info', isEqualTo: 'masjid')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pengurus RT 11 RW 09',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: baseContentColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${user?.displayName}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    const Icon(
                      Icons.notifications,
                      color: baseContentColor,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Content Informasi Warga
            Material(
              elevation: 2,
              child: Container(
                width: size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(22.0),
                        child: Text(
                          'Informasi terbaru warga',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _infoWarga,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return SizedBox(
                            height: 220,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> dataInfoWarga =
                                    document.data()! as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    CardInformation(
                                      titleCard: dataInfoWarga['title'],
                                      bodyCard: dataInfoWarga['body'],
                                      imgCard: dataInfoWarga['image'] == null
                                          ? 'assets/images/Image_404.svg'
                                          : 'assets/images/Image_404.svg',
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Material(
              elevation: 2,
              child: Container(
                width: size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(22.0),
                        child: Text(
                          'Informasi terbaru masjid',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _infoMasjid,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return SizedBox(
                            height: 220,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> dataInfoMasjid =
                                    document.data()! as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    CardInformation(
                                      titleCard: dataInfoMasjid['title'],
                                      bodyCard: dataInfoMasjid['body'],
                                      imgCard: dataInfoMasjid['image'] == null
                                          ? 'assets/images/Image_404.svg'
                                          : 'assets/images/Image_404.svg',
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
