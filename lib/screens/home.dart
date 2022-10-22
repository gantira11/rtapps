// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rtapp/constants.dart';
import 'package:rtapp/main.dart';
import 'package:rtapp/screens/pages/akun_page.dart';
import 'package:rtapp/screens/pages/home_page.dart';
import 'package:rtapp/screens/pages/pengajuan_page.dart';
import 'package:rtapp/screens/pages/ronda_page.dart';
import 'package:rtapp/services/fire_messaging.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

ValueNotifier<int> notificationCounterValueNotifier = ValueNotifier(0);

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  List userData = [];
  int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> bottomNavMenu = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.paste_outlined),
      label: 'Pengajuan Surat',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.date_range_outlined),
      label: 'Jadwal Ronda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Akun',
    ),
  ];

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    PengajuanPage(),
    RondaPage(),
    AkunPage()
  ];

  Future<void> setupToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    await FireMessaging.saveTokenToDatabase(token!);

    FirebaseMessaging.instance.onTokenRefresh
        .listen(FireMessaging.saveTokenToDatabase);
  }

  @override
  void initState() {
    setupToken();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              channelDescription: channel?.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   'notif',
      //   arguments: NotifArgument(message),
      // );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavMenu,
        currentIndex: _selectedIndex,
        elevation: 10,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
