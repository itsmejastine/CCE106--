import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome User,',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: primaryWhite,
              ),
            ),

            SizedBox(height: 70),
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: primaryWhite,
              ),
            ),

            // CONTAINER WIDGET OF TOTAL BALANCE //
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.yellow, // Green color at the top
                    Colors.green, //  color at the bottom
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'P100,000.00',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            //CONTAINER WIDGET OF TOTAL INCOME AND EXPENSES//
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    color: primaryGray,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Income',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryWhite,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'P70,000.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 100,
                  width: 185,
                  decoration: BoxDecoration(
                    color: primaryGray,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Expenses',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryWhite,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'P70,000.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'October 2023 v',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: primaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // BUTTONS  MONEY IN AND MONEY//
            const SizedBox(
              height: 350,
            ),
            Visibility(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 54,
                    width: 190,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'loginPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        elevation: 0,
                      ),
                      child: const Text(
                        "Money In",
                        style: TextStyle(color: primaryWhite, fontSize: 20),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 54,
                    width: 190,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'loginPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        elevation: 0,
                      ),
                      child: const Text(
                        "Money Out",
                        style: TextStyle(color: primaryWhite, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
