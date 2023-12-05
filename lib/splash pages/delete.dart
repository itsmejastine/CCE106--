import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/addTransaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:gradient_icon/gradient_icon.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> with SingleTickerProviderStateMixin {
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
