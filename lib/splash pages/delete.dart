import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashDelete extends StatefulWidget {
  const SplashDelete({super.key});

  @override
  State<SplashDelete> createState() => _SplashDeleteState();
}

class _SplashDeleteState extends State<SplashDelete> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.delete_forever_outlined,
          size: 165,
          color: primaryRed,
        ),
        const SizedBox(
          height: 28,
        ),
        SizedBox(
          width: 350,
          child: Text(
            "Transaction is deleted succesfully",
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
