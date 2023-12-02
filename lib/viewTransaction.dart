import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTransaction extends StatefulWidget {
  const ViewTransaction({super.key});

  @override
  State<ViewTransaction> createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  //firestore
  final FirestoreService firestorService = FirestoreService();

  String appBarText = "Money Out";

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              //-------Transaction ID------------
              Text(
                'ID:  #aerfvgtyuYTRVHUtagsbs',
                style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.displaySmall,
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
                    "Php 24,000.00",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
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
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Jollibee",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
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
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "10/21/2023",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
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
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Food",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
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
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Cash",
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 24,
                      color: primaryWhite,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
