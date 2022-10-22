// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String nama,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(nama);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.showInfo('Kata sandi yang diberikan terlalu lemah');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showInfo('Email sudah terdaftar');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<void> storeUser({
    required String uid,
    required String nik,
    required String nama,
    required String noHp,
    required String email,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    try {
      users
          .doc(uid)
          .set({
            'nik': nik,
            'nama_lengkap': nama,
            'phone': noHp,
            'email': email,
          })
          .then((res) => print('User Added'))
          .catchError((error) => print(error));
    } catch (e) {
      print(e);
    }
  }

  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showInfo('Email tidak terdaftar');
      } else if (e.code == 'wrong-password') {
        EasyLoading.showInfo('Password tidak valid');
      }
    }
    return user;
  }
}
