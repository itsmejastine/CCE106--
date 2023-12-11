import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/transaction%20pages/viewTransaction.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome User,',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: primaryWhite,
              ),
            ),
            const SizedBox(height: 60),
            const Center(
              child: Text(
                'Balance',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: primaryWhite,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GradientText(
                'P 100,000.00',
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [gradientGreen, gradientYellow],
              ),
            ),
            const SizedBox(height: 50.0),
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Added this line
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite,
                  ),
                ),
                Text(
                  'See all >',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Flexible(
              child: StreamBuilder(
                  stream:
                      firestoreService.getTransactions().handleError((error) {
                    print(error);
                  }),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                          child: Text(
                        'No Transactions Yet',
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 20,
                          color: primaryWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ));
                    } else {
                      //if there is data, get all

                      List transactionList = snapshot.data!.docs;

                      //display list
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: transactionList.length,
                        itemBuilder: (context, index) {
                          //get each individual doc
                          DocumentSnapshot document = transactionList[index];
                          String docID = document.id;

                          //get note from each doc
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String transactionText = data['description'];
                          String dateText = data['date'];
                          String amount = data['amount'].toString();
                          String type = data['type'];
                          String amountText = '';

                          if (type == 'Expenses') {
                            amountTextColor = primaryRed;
                            amountText = "- Php $amount";
                          } else {
                            amountTextColor = primaryGreen;
                            amountText = "+ Php $amount";
                          }

                          return Expanded(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewTransaction(docID: docID)));
                              },
                              title: Text(
                                transactionText,
                                style: GoogleFonts.inter(
                                  textStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  fontSize: 16,
                                  color: primaryWhite,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                dateText,
                                style: GoogleFonts.inter(
                                  textStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  fontSize: 12,
                                  color: primaryWhite,
                                ),
                              ),
                              trailing: Text(
                                amountText,
                                style: GoogleFonts.inter(
                                  textStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  fontSize: 16,
                                  color: amountTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
