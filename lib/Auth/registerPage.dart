import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userNameController = TextEditingController();
  final _emailRegController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //login user method
  void RegisterUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      // checks if the password matches
      if (_passwordController.text != _confirmPasswordController.text) {
        //show error message, passwords don't match
        Navigator.pop(context);
        errorMessage('Password does not match');
        return;
      } else {
        //try sign in
        try {
          UserCredential? userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailRegController.text,
                  password: _passwordController.text);

          createUserDocument(userCredential);

          //pop the loading circle
          if (context.mounted) Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          //pop the loading circle
          Navigator.pop(context);

          //error Message
          errorMessage(e.code);
        }
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': _userNameController.text,
      });
    }
  }

  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
                Text(message, style: TextStyle(color: primaryWhite)),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailRegController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 36),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(100),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        border: const GradientBoxBorder(
                      gradient: LinearGradient(
                          colors: [gradientGreen, gradientYellow]),
                      width: 20,
                    )),
                    child: Image.asset(
                      '../lib/images/zzz.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'REGISTRATION',
                style: GoogleFonts.daysOne(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  fontSize: 32,
                  color: primaryWhite,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      },
                      style: TextStyle(color: primaryWhite),
                      decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(color: primaryGreen),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: primaryGreen,
                          ),
                          iconColor: primaryGreen,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color:
                                    primaryGreen), //colors does not work for the border of the textField
                          )),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _emailRegController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      },
                      style: TextStyle(color: primaryWhite),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: primaryGreen),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: primaryGreen,
                          ),
                          iconColor: primaryGreen,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color:
                                    primaryGreen), //colors does not work for the border of the textField
                          )),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a pasword";
                        }
                        return null;
                      },
                      style: const TextStyle(color: primaryWhite),
                      decoration: InputDecoration(
                          hintText: "Password",
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
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a pasword";
                        }
                        return null;
                      },
                      style: const TextStyle(color: primaryWhite),
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 48,
                width: 294,
                child: ElevatedButton(
                  onPressed: () => RegisterUser(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    elevation: 0,
                  ),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(color: primaryWhite),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
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
                      'Login Here',
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 12,
                        color: primaryGreen,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
