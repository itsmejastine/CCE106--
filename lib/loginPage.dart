import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 74, 16, 74),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 196,
                height: 102,
                child: const Image(image: AssetImage("lib/images/logo.png")),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              'WELCOME',
              style: GoogleFonts.daysOne(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 32,
                color: primaryWhite,
              ),
            ),
            Text(
              'COMPANION',
              style: GoogleFonts.daysOne(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 32,
                color: primaryWhite,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '“Accumulate savings effortlessly, without the need for conscious effort. “',
              style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displaySmall,
                fontSize: 16,
                color: primaryWhite,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48,
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: primaryWhite),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                SizedBox(
                  height: 48,
                  width: 170,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "Register",
                      style: TextStyle(color: primaryGreen),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryGreen)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            const Text(
              "© Almonte & Villacis 2023",
              style: TextStyle(color: primaryWhite, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
