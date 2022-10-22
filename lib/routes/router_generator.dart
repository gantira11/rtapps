import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rtapp/screens/home.dart';
import 'package:rtapp/screens/login_screen.dart';
import 'package:rtapp/screens/pengajuan_surat_screen.dart';
import 'package:rtapp/screens/register_screen.dart';
import 'package:rtapp/screens/splash_screen.dart';
import 'package:rtapp/screens/struktur_masjid_screen.dart';
import 'package:rtapp/screens/struktur_pengurus_screen.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case 'register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => const Home());
      case 'pengajuan-surat':
        final args = settings.arguments as SuratArguments;
        return MaterialPageRoute(
          builder: (_) => PengajuanSuratScreen(
            title: args.title,
          ),
        );
      case 'struktur-masjid':
        return MaterialPageRoute(builder: (_) => const StrukturMasjidScreen());
      case 'struktur-pengurus':
        return MaterialPageRoute(
            builder: (_) => const StrukturPengurusScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found!"),
        ),
        body: const Center(
          child: Text("404"),
        ),
      );
    });
  }
}

class SuratArguments {
  final String title;

  SuratArguments(this.title);
}

class NotifArgument {
  final RemoteMessage notif;

  NotifArgument(this.notif);
}
