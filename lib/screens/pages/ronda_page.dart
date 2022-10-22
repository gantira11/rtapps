import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';

class RondaPage extends StatefulWidget {
  const RondaPage({Key? key}) : super(key: key);

  @override
  State<RondaPage> createState() => _RondaPageState();
}

class _RondaPageState extends State<RondaPage> {
  final Stream<QuerySnapshot> _jadwalStream = FirebaseFirestore.instance
      .collection('ronda')
      .orderBy('tanggal')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          'Jadwal Ronda',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: baseContentColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _jadwalStream,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('something went wrong'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    print(snapshot);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 4),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                left: 20,
                                right: 20,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    data['hari'],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 20,
                                  ),
                                  for (int i = 0;
                                      i < data['nama_warga'].length;
                                      i++)
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        data['nama_warga'][i],
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
