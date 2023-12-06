import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                    onPressed: () {
                      Navigator.pushNamed(context, 'loginPage');
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
                  width: 6,
                ),
                SizedBox(
                  height: 48,
                  width: 170,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryGreen)),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: primaryGreen),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "© Almonte & Villacis 2023",
              style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displaySmall,
                fontSize: 12,
                color: primaryWhite,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
