import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
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

  late Stream<DocumentSnapshot<Map<String, dynamic>>> transactionStream;

  String appBarText = "Money Out";

  @override
  void initState() {
    super.initState();
    transactionStream = FirebaseFirestore.instance
        .collection("transaction")
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
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  } else {
                    final data = snapshot.data!.data() as Map<String, dynamic>;

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
                              "Php ${data['amount']}",
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
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: primaryGray,
                                    )),
                                const Text(
                                  'Edit',
                                  style: TextStyle(color: primaryGray),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: primaryGray,
                                    )),
                                const Text(
                                  'Delete',
                                  style: TextStyle(color: primaryGray),
                                )
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
                              "${data['description']}",
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
                              "${data['description']}",
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
                              "${data['category']}",
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
                              "${data['payment']}",
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
