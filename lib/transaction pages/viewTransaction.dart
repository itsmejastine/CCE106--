import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/transaction%20pages/updateTransaction.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTransaction extends StatefulWidget {
  final String? docID;
  const ViewTransaction({Key? key, this.docID}) : super(key: key);

  @override
  State<ViewTransaction> createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  late Stream<DocumentSnapshot<Map<String, dynamic>>> transactionStream;
  void deleteModal() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: mobileBackgroundColor,
              title: const Icon(
                Icons.delete_forever_outlined,
                color: primaryRed,
                size: 108,
              ),
              content: const Text('Are you sure to delete this transaction?',
                  style: TextStyle(color: primaryWhite)),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      firestoreService.deleteTransaction('${widget.docID}');
                      Navigator.pushNamed(context, 'transact');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: primaryWhite),
                    child: const Text('Yes'),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGray,
                        foregroundColor: primaryWhite),
                    child: const Text('No'),
                  ),
                )
              ]);
        });
  }

  String appBarText = "Money In";

  @override
  void initState() {
    super.initState();
    transactionStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('transaction')
        .doc(widget.docID)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          leading: BackButton(
            color: appBarTextColor,
          ),
          title: Text(
            appBarText,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displaySmall,
                fontSize: 24,
                color: appBarTextColor,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          child: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: transactionStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final data = snapshot.data!.data() as Map<String, dynamic>;

                    String description = data['description'];
                    String amount = data['amount'].toString();
                    String date = data['date'];
                    String category = data['category'];
                    String payment = data['payment'];
                    String type = data['type'];

                    if (type == 'Expenses') {
                      Future.delayed(Duration.zero, () {
                        setState(() {
                          appBarText = 'Money Out';
                          appBarBgColor = primaryRed;
                          amountTextColor = primaryRed;
                        });
                      });
                    } else {
                      Future.delayed(Duration.zero, () {
                        setState(() {
                          appBarText;
                          appBarBgColor = primaryGreen;
                          amountTextColor = primaryGreen;
                        });
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 45),
                        //-------Transaction ID------------
                        Text(
                          'ID: ${widget.docID}',
                          style: GoogleFonts.inter(
                              textStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              fontSize: 16,
                              color: primaryWhite,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        //-------Amount------------
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Php $amount",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 32,
                                color: amountTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateTransaction(
                                                      updateID:
                                                          '${widget.docID}')));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: primaryGray,
                                    ),
                                    label: const Text(
                                      'Edit',
                                      style: TextStyle(color: primaryGray),
                                    )),
                                //
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      deleteModal();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: primaryGray,
                                    ),
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(color: primaryGray),
                                    )),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        //-------DESCRIPTION------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryWhite,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              description,
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 24,
                                color: primaryWhite,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        //-------DATE------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryWhite,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date,
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 24,
                                color: primaryWhite,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        //-------CATEGORY------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryWhite,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category,
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 24,
                                color: primaryWhite,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        //-------MOP------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mode of Payment",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryWhite,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              payment,
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 24,
                                color: primaryWhite,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                }),
          ),
        ));
  }
}
