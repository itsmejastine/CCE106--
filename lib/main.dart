import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/Auth/authenticator.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/splash%20pages/success.dart';
import 'package:flutter_it14proj/splash%20pages/update.dart';
import 'package:flutter_it14proj/components/navBar.dart';
import 'package:flutter_it14proj/transaction%20pages/transactionPage.dart';
import 'package:flutter_it14proj/profile.dart';
import 'package:flutter_it14proj/viewGoal.dart';
import 'package:flutter_it14proj/welcomePage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashFlowCompanion',
      theme: ThemeData(
        scaffoldBackgroundColor: mobileBackgroundColor,
        useMaterial3: true,
      ),
      home: const Authenticator(),
      routes: {
        'welcomePage': (context) => const WelcomePage(),
        'profilePage': (context) => const ProfilePage(),
        'navBarPage': (context) => NavBarPage(initialIndex: 0),
        'viewGoal': (context) => const ViewGoal(),
        'transact': (context) => const New(),
        'splashUpdate': (context) => SplashUpdate(),
        'splashAdd': (context) => Success(),
        //add routes here
      },
    );
  }
}
