import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MoneyIn extends StatefulWidget {
  const MoneyIn({super.key});

  @override
  State<MoneyIn> createState() => _MoneyInState();
}

class _MoneyInState extends State<MoneyIn> {
  //firestore
  final FirestorService firestorService = FirestorService();

  //text controllers
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController paymentController = TextEditingController();

  //type variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: primaryWhite,
        ),
        title: Text('Back', style: TextStyle(color: primaryWhite)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'moneyIn');
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(21, 160, 39, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                          ),
                          side: const BorderSide(
                            color: primaryGreen,
                          )),
                      child: const Text(
                        "Money In",
                        style: TextStyle(color: primaryWhite),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'moneyOut');
                      },
                      style: OutlinedButton.styleFrom(
                          //backgroundColor: Color.fromRGBO(21, 160, 39, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                          ),
                          side: const BorderSide(
                            color: primaryGray,
                          )),
                      child: const Text(
                        "Money Out",
                        style: TextStyle(color: primaryGray),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Description",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryGreen,
                        ),
                      ),
                      Text(
                        "*",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Form(
                    child: TextFormField(
                      controller: descriptionController,
                      style: TextStyle(
                          fontSize: 32,
                          color: primaryWhite,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        hintStyle: TextStyle(
                            color: primaryGray,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w100,
                            fontSize: 32),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Amount",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryGreen,
                        ),
                      ),
                      Text(
                        "*",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Form(
                    child: TextFormField(
                      controller: amountController,
                      style: TextStyle(
                          fontSize: 24,
                          color: primaryWhite,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: "0.00",
                        hintStyle: TextStyle(
                            color: primaryGray,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Date",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryGreen,
                        ),
                      ),
                      Text(
                        "*",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Form(
                    child: TextFormField(
                      controller: dateController,
                      style: TextStyle(
                          fontSize: 24,
                          color: primaryWhite,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.date_range_rounded,
                          color: primaryWhite,
                        ),
                        hintText: "mm/dd/yyyy",
                        hintStyle: TextStyle(
                            color: primaryGray,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Category",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Form(
                    child: TextFormField(
                      controller: categoryController,
                      style: TextStyle(
                          fontSize: 24,
                          color: primaryWhite,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: "Uncategorize",
                        hintStyle: TextStyle(
                            color: primaryGray,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Mode of Payment",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          color: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Form(
                    child: TextFormField(
                      controller: paymentController,
                      style: TextStyle(
                          fontSize: 24,
                          color: primaryWhite,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: "Enter Mode of Payment",
                        hintStyle: TextStyle(
                            color: primaryGray,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String description = descriptionController.text;
                      double amount = double.parse(amountController.text);
                      String date = dateController.text;
                      String category = categoryController.text;
                      String payment = paymentController.text;
                      String type = "Income";
                      firestorService.addTransaction(
                          description, amount, date, category, payment, type);

                      descriptionController.clear();
                      amountController.clear();
                      dateController.clear();
                      categoryController.clear();
                      paymentController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      elevation: 0,
                    ),
                    child: const Text(
                      "Add Income",
                      style: TextStyle(color: primaryWhite, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
