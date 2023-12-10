import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/Auth/loginPage.dart';
import 'package:flutter_it14proj/home.dart';
import 'package:flutter_it14proj/transaction%20pages/addTransaction.dart';
import 'package:flutter_it14proj/profile.dart';
import 'package:flutter_it14proj/transaction%20pages/transactionPage.dart';
import 'package:flutter_it14proj/viewGoal.dart';
import 'package:flutter_it14proj/welcomePage.dart';

class NavBarPage extends StatefulWidget {
  final int initialIndex;

  const NavBarPage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _currentIndex = 0;

  final pages = [
    Home(),
    New(),
    ViewGoal(),
    ProfilePage()
  ]; //change it to its corresponding page

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set initial index in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_alt),
            label: 'Transaction',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Savings Goal',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: mobileBackgroundColor,
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: primaryGreen,
        unselectedItemColor: primaryWhite,
        onTap: _onItemTapped,
      ),
    );
  }
}
