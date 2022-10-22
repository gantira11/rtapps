import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rtapp/screens/home.dart';
import 'package:rtapp/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;

  void _checkAuth() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        nextScreen: !_isLoggedIn ? const LoginScreen() : const Home(),
        splashIconSize: double.maxFinite,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        animationDuration: const Duration(milliseconds: 1500),
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/Splash.json',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
