import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'H O M E  P A G E',
        style: TextStyle(color: primaryWhite),
      )),
    );
  }
}
