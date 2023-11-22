import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "email",
                      prefixIcon: const Icon(
                        Icons.people,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a pasword";
                    }
                    return null;
                  },
                  style: const TextStyle(color: primaryWhite),
                  decoration: InputDecoration(
                      hintText: "password",
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
                  Navigator.pushNamed(context, '');
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
                  onTap: () =>
                      launchUrlString('')) //add route of the register page
            ],
          ),
        ],
      ),
    ));
  }
}
