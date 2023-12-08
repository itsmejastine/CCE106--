import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/Auth/LoginOrRegister.dart';
import 'package:flutter_it14proj/Auth/loginPage.dart';
import 'package:flutter_it14proj/components/navBar.dart';
import 'package:flutter_it14proj/profile.dart';

//to check if the user is signed in  or not
class Authenticator extends StatelessWidget {
  const Authenticator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), //listenign if the user is logged in or not
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return NavBarPage(initialIndex: 0,);
          }
          //user is NOT logged in
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
