import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/transaction%20pages/addTransaction.dart';
import 'package:flutter_it14proj/transaction%20pages/viewTransaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  final FirestoreService firestoreService = FirestoreService();
  late Future<double> totalIncome;
  late Future<double> totalExpense;
  late Future<double> currentBalance;

  User? currentUser = FirebaseAuth.instance.currentUser;

  //gets the details of the user
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  void initState() {
    super.initState();
    totalIncome = firestoreService.totalIncome();
    totalExpense = firestoreService.totalExpenses();
    currentBalance = firestoreService.userBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Foating buttton of Money in/out
          Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 190,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MoneyIn(
                                  buttonState: 1,
                                )),
                      );
                    },
                    label: Text(
                      'Money In',
                      style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryWhite),
                    ),
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(95)),
                  ),
                )),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 190,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MoneyIn(
                                  buttonState: 2,
                                )),
                      );
                    },
                    label: Text(
                      'Money Out',
                      style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryWhite),
                    ),
                    backgroundColor: primaryRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(95)),
                  ),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //getss and display the user Username
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

          const SizedBox(height: 40),
          Text(
            'Overview',
            style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryWhite),
          ),
          const SizedBox(height: 16),
          Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    gradientYellow, // Green color at the top
                    gradientGreen, //  color at the bottom
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              alignment: Alignment.topLeft,
              //getss and display the user Balance
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "Calculating...",
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayMedium,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: textGreen,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    Map<String, dynamic>? user = snapshot.data!.data();

                    return Text(
                      "Php ${user!['balance']}",
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayMedium,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: textGreen,
                      ),
                    );
                  } else {
                    return const Text("No data");
                  }
                },
              )),

          const SizedBox(height: 16),
          //CONTAINER WIDGET OF TOTAL INCOME AND EXPENSES//
          Row(
            children: [
              Container(
                height: 100,
                width: 190,
                decoration: BoxDecoration(
                  color: primaryGray,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Income',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    //getss and display the user Income
                    FutureBuilder<double>(
                      future: totalIncome,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            'Calculating...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ); // Show a loader while fetching data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Display the fetched total income in a Text widget
                          return Text(
                            'Php ${snapshot.data}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 100,
                width: 190,
                decoration: BoxDecoration(
                  color: primaryGray,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    //getss and display the user Expenses
                    FutureBuilder<double>(
                      future: totalExpense,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            'Calculating...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryRed,
                            ),
                          ); // Show a loader while fetching data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Display the fetched total income in a Text widget
                          return Text(
                            'Php ${snapshot.data}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryRed,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),
          Text(
            'Transactions',
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.displaySmall,
              fontSize: 20,
              color: primaryWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          //STREAMBUILDER
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
                          textStyle: Theme.of(context).textTheme.headlineMedium,
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
                    height: 350,
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
                    ),
                  );
                }
              })),
        ]),
      ),
    );
  }
}
