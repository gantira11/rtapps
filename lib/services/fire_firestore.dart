// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FireFirestore {
  static Future<void> storeSurat({
    required String namaLengkap,
    required String tempatLahir,
    required String tanggalLahir,
    required String jenisKelamin,
    required String agama,
    required String alamat,
    required String jenisSurat,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference surat = firestore.collection('surat');
    try {
      surat
          .add({
            'nama_lengkap': namaLengkap,
            'tempat_lahir': tempatLahir,
            'tanggal_lahir': tanggalLahir,
            'jenis_kelamin': jenisKelamin,
            'agama': agama,
            'alamat': alamat,
            'jenis_surat': jenisSurat,
          })
          .then((res) => EasyLoading.showSuccess('Surat telah diajukan'))
          .catchError((err) => EasyLoading.showInfo('Gagal mengajukan surat'));
    } catch (e) {
      print(e);
    }
  }
}
