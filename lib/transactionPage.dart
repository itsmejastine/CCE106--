import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/moneyIn.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: SingleChildScrollView(
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

              const SizedBox(height: 40),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: primaryWhite,
                ),
              ),

              // CONTAINER WIDGET OF TOTAL BALANCE //
              const SizedBox(height: 20),
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

              //CONTAINER WIDGET OF TOTAL INCOME AND EXPENSES//
              const SizedBox(height: 16),
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
              //STREAM BUILDER
              Flexible(
                child: StreamBuilder(
                    stream:
                        firestoreService.getTransactions().handleError((error) {
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

                            return Expanded(
                              child: ListTile(
                                title: Text(
                                  transactionText,
                                  style: TextStyle(color: primaryWhite),
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
                          Navigator.pushNamed(context, 'moneyIn');
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
                    const Spacer(),
                    SizedBox(
                      height: 54,
                      width: 190,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            'moneyIn',
                          );
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
      ),
    );
  }
}
