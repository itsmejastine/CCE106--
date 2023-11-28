import 'dart:js_interop';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errormessage;
  late bool isError;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errormessage = "This is an error";
    isError = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 74, 16, 74),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: SizedBox(
              width: 196,
              height: 102,
              child: Image(image: AssetImage("lib/images/logo.png")),
            ),
          ),
          Text(
            'LOGIN',
            style: GoogleFonts.daysOne(
              textStyle: Theme.of(context).textTheme.displayMedium,
              fontSize: 32,
              color: primaryWhite,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  style: TextStyle(color: primaryWhite),
                  decoration: InputDecoration(
                      hintText: "email",
                      hintStyle: TextStyle(color: primaryGreen),
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: primaryGreen,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color:
                              primaryGreen, //colors does not work for the border of the textField
                        ),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a pasword";
                    }
                    return null;
                  },
                  style: const TextStyle(color: primaryWhite),
                  decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(color: primaryGreen),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: primaryGreen,
                      ),
                      iconColor: primaryGreen,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color:
                                primaryGreen), //colors does not work for the border of the textField
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 48,
            width: 294,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  checkLogin(
                    emailController.text,
                    passwordController.text,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                elevation: 0,
              ),
              child: const Text(
                "LOGIN",
                style: TextStyle(color: primaryWhite),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do not have an account yet? ",
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  fontSize: 12,
                  color: primaryWhite,
                ),
                textAlign: TextAlign.center,
              ),
              InkWell(
                  child: Text(
                    'Register Now',
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 12,
                      color: primaryGreen,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'register');
                  }) //add route of the register page
            ],
          ),
        ],
      ),
    ));
  }

  Future checkLogin(email, password) async {
    showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        errormessage = '';
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      setState(() {
        errormessage = e.message.toString();
      });
    }
    Navigator.pushNamed(context, 'profilePage');
  }
}
