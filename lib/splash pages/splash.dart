import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (_) => const WelcomePage(),
    //     ),
    //   );
    // });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 196,
              height: 102,
              child: Image(image: AssetImage("lib/images/logo.png")),
            ),
          ),
          Column(
            children: [
              Text(
                'CASH FLOW',
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
            ],
          )
        ],
      ),
    );
  }
}
