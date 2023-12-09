import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_icon/gradient_icon.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  //textEditing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //formKey
  final _formKey = GlobalKey<FormState>();

  //login user method
  void logUserIn() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      //try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        //pop the loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);
        //wrong email
        if (e.code == 'invalid-email') {
          //show error
          wrongEmailMessage();
        }
        //wrong password
        else if (e.code == 'invalid-login-credentials') {
          //show error
          wrongPasswordMessage();

          //wrong credentials
        }
      }
    }
  } //last loginUser

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: mobileBackgroundColor,
            title: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: primaryRed,
                  size: 90,
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Wrong password', style: TextStyle(color: primaryWhite)),
              ],
            ),
          );
        });
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: mobileBackgroundColor,
            title: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: primaryRed,
                  size: 90,
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Incorrect Email', style: TextStyle(color: primaryWhite)),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 74, 16, 74),
      child: SingleChildScrollView(
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
                    obscureText: _obscureText,
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
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: primaryGreen,
                        ),
                        iconColor: primaryGreen,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: primaryGreen),
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
                onPressed: logUserIn,
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
                GestureDetector(
                  onTap: widget.onTap,
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
                ) //add route of the register page
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
