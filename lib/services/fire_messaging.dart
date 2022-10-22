// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireMessaging {
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  static Future<void> saveTokenToDatabase(String token) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'tokens': FieldValue.arrayUnion([token])
    });
  }
}
