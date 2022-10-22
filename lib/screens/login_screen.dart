import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rtapp/components/button_block.dart';
import 'package:rtapp/components/text_input_default.dart';
import 'package:rtapp/components/text_input_suffix.dart';
import 'package:rtapp/constants.dart';
import 'package:rtapp/services/fire_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 68),
                child: Center(
                  // child: Image.asset(
                  //   'assets/images/Login.svg',
                  //   width: size.width * 0.8,
                  // ),
                  child: SvgPicture.asset(
                    'assets/images/SignIn.svg',
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Selamat datang kembali!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: baseContentColor,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Sign in untuk melanjutkan',
                style: TextStyle(
                  fontFamily: 'lato',
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: baseContentColor,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInputDefault(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? _emailController) {
                        if (_emailController == null ||
                            _emailController.isEmpty) {
                          return 'Field tidak boleh kosong!';
                        } else if (!EmailValidator.validate(_emailController)) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Password TextFormField
                    TextInputSuffix(
                      controller: _passwordController,
                      labelText: 'Password',
                      iconData: !showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      obscureText: showPassword,
                      keyboardType: TextInputType.text,
                      validator: (String? _passwordController) {
                        if (_passwordController == null ||
                            _passwordController.isEmpty) {
                          return 'Password tidak boleh kosong';
                        } else if (_passwordController.length < 6) {
                          return 'Password harus lebih dari 6';
                        }
                        return null;
                      },
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    ButtonBlock(
                      buttonText: 'Sign In',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user = await FireAuth.signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (user != null) {
                            await EasyLoading.showSuccess(
                              'Login berhasil',
                              maskType: EasyLoadingMaskType.clear,
                            );
                            Navigator.pushReplacementNamed(context, 'home');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Belum memiliki akun? ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: baseContentColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Daftar disini!',
                        style: const TextStyle(
                          color: primaryFocusColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, 'register'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    ));
  }
}
