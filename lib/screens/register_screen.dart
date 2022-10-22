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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Image.asset(
                //     'assets/images/Register.svg',
                //     width: size.width * 0.68,
                //     fit: BoxFit.contain,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    // child: Image.asset(
                    //   'assets/images/Login.svg',
                    //   width: size.width * 0.8,
                    // ),
                    child: SvgPicture.asset(
                      'assets/images/SignUp.svg',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInputDefault(
                        labelText: 'NIK (Nomor Induk Kependudukan)',
                        controller: _nikController,
                        keyboardType: TextInputType.number,
                        maxLength: 15,
                        validator: (String? _nikController) {
                          if (_nikController == null ||
                              _nikController.isEmpty) {
                            return 'NIK tidak boleh kosong';
                          } else if (_nikController.length <= 14) {
                            return 'NIK harus berisi 15 angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextInputDefault(
                        labelText: 'Nama Lengkap',
                        controller: _namaController,
                        keyboardType: TextInputType.text,
                        validator: (String? _namaController) {
                          if (_namaController == null ||
                              _namaController.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextInputDefault(
                        labelText: 'Nomor HP',
                        controller: _noHpController,
                        keyboardType: TextInputType.number,
                        validator: (String? _noHpController) {
                          if (_noHpController == null ||
                              _noHpController.isEmpty) {
                            return 'Nomor HP tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextInputDefault(
                        labelText: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? _emailController) {
                          if (_emailController == null ||
                              _emailController.isEmpty) {
                            return 'Email tidak boleh kosong';
                          } else if (!EmailValidator.validate(
                              _emailController)) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextInputSuffix(
                        controller: _passwordController,
                        labelText: 'Password',
                        iconData: !showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        obscureText: showPassword,
                        keyboardType: TextInputType.text,
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        validator: (String? _passwordController) {
                          if (_passwordController == null ||
                              _passwordController.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (_passwordController.length < 6) {
                            return 'Password harus lebih dari 6';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      ButtonBlock(
                        buttonText: 'Sign Up',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              EasyLoading.show(status: 'Mohon Tunggu.');
                            });

                            User? user =
                                await FireAuth.registerUsingEmailPassword(
                              nama: _namaController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            if (user != null) {
                              await FireAuth.storeUser(
                                nik: _nikController.text,
                                nama: _namaController.text,
                                noHp: _noHpController.text,
                                email: _emailController.text,
                                uid: user.uid,
                              );
                              setState(() {
                                EasyLoading.dismiss();
                                EasyLoading.showSuccess('Register Berhasil');
                              });
                              Navigator.pushReplacementNamed(context, 'home');
                              // Navigator.push
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah memiliki akun? ',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: baseContentColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login disini!',
                          style: const TextStyle(
                            color: primaryFocusColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Navigator.pushNamed(context, 'login'),
                        ),
                      ],
                    ),
                  ),
                ),
                // Row()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
