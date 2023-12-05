import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/viewTransaction.dart';
import 'package:google_fonts/google_fonts.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 190,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, 'moneyIn');
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
                      Navigator.pushNamed(context, 'moneyIn');
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
        child: Column(children: [
          Text(
            'Welcome User,',
            style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: primaryWhite),
          ),
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  gradientYellow, // Green color at the top
                  gradientGreen, //  color at the bottom
                ],
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            alignment: Alignment.topLeft,
            child: const Text(
              'P100,000.00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

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
                child: const Column(
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
                child: const Column(
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

          const SizedBox(height: 40),
          const Row(
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
          const SizedBox(height: 20),
          //STREAMBUILDER
          Flexible(
            child: StreamBuilder(
                stream: firestoreService.getTransactions().handleError((error) {
                  print(error);
                }),
                builder: ((context, snapshot) {
                  //if there is data, get all
                  if (snapshot.hasData) {
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
                              style: const TextStyle(color: primaryWhite),
                            ),
                            subtitle: Text(
                              dateText,
                              style: const TextStyle(color: primaryWhite),
                            ),
                            trailing: Text(
                              'Php $amount',
                              style: const TextStyle(color: primaryWhite),
                            ),
                          ),
                        );
                      },
                    );
                  } //if there is no data
                  else {
                    return const Text('No transactions Yet..');
                  }
                })),
          ),
        ]),
      ),
    );
  }
}
