import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashUpdate extends StatefulWidget {
  const SplashUpdate(BuildContext context, {super.key});

  @override
  State<SplashUpdate> createState() => _SplashUpdateState();
}

class _SplashUpdateState extends State<SplashUpdate>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.edit_document,
          size: 165,
          color: primaryGreen,
        ),
        const SizedBox(
          height: 28,
        ),
        SizedBox(
          width: 350,
          child: Text(
            "Transaction Updated",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: primaryWhite,
            ),
          ),
        )
      ]),
    ));
  }
}
