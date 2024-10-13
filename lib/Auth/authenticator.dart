import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/Auth/loginOrRegister.dart';
import 'package:flutter_it14proj/components/navBar.dart';

class Authenticator extends StatelessWidget {
  const Authenticator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), //listes if the user is logged in or not
        builder: (context, snapshot) {
          //to check if the user is signed in  or not
          //user is logged in
          if (snapshot.hasData) {
            return const NavBarPage(
              initialIndex: 0,
            );
          }
          //user is NOT logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
