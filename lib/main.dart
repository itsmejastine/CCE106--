import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/Auth/authenticator.dart';
import 'package:flutter_it14proj/Auth/loginPage.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/splash%20pages/update.dart';
import 'package:flutter_it14proj/transaction%20pages/addTransaction.dart';
import 'package:flutter_it14proj/components/navBar.dart';
import 'package:flutter_it14proj/transaction%20pages/transactionPage.dart';
import 'package:flutter_it14proj/profile.dart';
import 'package:flutter_it14proj/Auth/registerPage.dart';
import 'package:flutter_it14proj/splash%20pages/splash.dart';
import 'package:flutter_it14proj/viewGoal.dart';
import 'package:flutter_it14proj/transaction%20pages/viewTransaction.dart';
import 'package:flutter_it14proj/welcomePage.dart';
import 'firebase_options.dart';
import 'package:flutter_it14proj/transaction%20pages/updateTransaction.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: mobileBackgroundColor,
        useMaterial3: true,
        //  textTheme: GoogleFonts.inter(Theme.of(context).textTheme.displaySmall)
      ),
      home: const New(),
      routes: {
        'welcomePage': (context) => const WelcomePage(),
        'loginPage': (context) => const LoginPage(),
        'profilePage': (context) => const ProfilePage(),
        'navBarPage': (context) => const NavBarPage(),
        'viewGoal': (context) => const ViewGoal(),
        'moneyIn': (context) => const MoneyIn(),
        'register': (context) => const RegisterPage(),
        'transact': (context) => const New(),
        'splashUpdate': (context) => SplashUpdate(context),
        //add routes here
      },
    );
  }
}
