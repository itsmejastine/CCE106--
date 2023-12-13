import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/components/navBar.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/transaction%20pages/viewTransaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_icon/gradient_icon.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreService firestoreService = FirestoreService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "...",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayMedium,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryWhite,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  Map<String, dynamic>? user = snapshot.data!.data();

                  return Text(
                    "Welcome ${user!['username']}",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayMedium,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryWhite,
                    ),
                  );
                } else {
                  return const Text("No data");
                }
              },
            )),
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
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GradientText(
                    'Calculating...',
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: const [gradientGreen, gradientYellow],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  Map<String, dynamic>? user = snapshot.data!.data();

                  return GradientText(
                    'Php ${user!['balance']}',
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: const [gradientGreen, gradientYellow],
                  );
                } else {
                  return const Text("No data");
                }
              },
            )),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Added this line
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavBarPage(
                                initialIndex: 1,
                              )),
                    );
                  },
                  child: Text(
                    'See more >',
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 18,
                      color: primaryGreen,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(height: 35),
            StreamBuilder(
                stream: firestoreService.getTransactions().handleError((error) {
                  print(error);
                }),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GradientIcon(
                            icon: Icons.folder_open_rounded,
                            size: 100,
                            gradient: LinearGradient(
                                colors: [gradientGreen, gradientYellow])),
                        GradientText(
                          'No Transactions Yet',
                          style: GoogleFonts.inter(
                            textStyle:
                                Theme.of(context).textTheme.headlineMedium,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          colors: const [gradientGreen, gradientYellow],
                        ),
                      ],
                    ));
                  } else {
                    //if there is data, get all

                    List transactionList = snapshot.data!.docs;

                    //display list
                    return SizedBox(
                      height: 500,
                      child: ListView.builder(
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

                          return ListTile(
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
                          );
                        },
                      ),
                    );
                  }
                })),
          ],
        ),
      ),
    );
  }
}
