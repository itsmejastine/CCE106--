import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/splash%20pages/success.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../splash pages/update.dart';

//Dropdown list
const List<String> paymentList = <String>[
  'None',
  'Cash',
  'Gcash',
  'Fund Transfer'
];
const List<String> incomeList = <String>[
  'Uncategorized',
  'Allowance',
  'Salary',
  'Government Aid',
  'Cash Savings',
  'Extra Income',
  'Others',
];
const List<String> expensesList = <String>[
  'Uncategorized',
  'Food',
  'Transportation',
  'Water Bill',
  'Electricty Bill',
  'Groceries',
  'Loans Payment',
  'Rent',
  'Travel',
];

class UpdateTransaction extends StatefulWidget {
  final String? updateID;
  const UpdateTransaction({Key? key, this.updateID}) : super(key: key);

  @override
  State<UpdateTransaction> createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransaction> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> updateStream;
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  //Calling dropdown
  String dropdownValue = paymentList.first;
  String categoryValue = incomeList.first;
  List<String> currentCategoryList = incomeList;
  bool isState = true;
  String currentDate = '';

  //button change
  void buttonState(bool state) {
    //Money In Button State
    if (state == true) {
      moneyInButton = const Color.fromRGBO(21, 160, 39, 80);
      moneyOutButton = mobileBackgroundColor;
      moneyInText = primaryWhite;
      moneyOutText = primaryGray;
      moneyInBorder = primaryGreen;
      moneyOutBorder = primaryGray;
      moneyInFontWeight = FontWeight.bold;
      moneyOutFontWeight = FontWeight.normal;
    } else {
      //Money out Button State
      moneyInButton = mobileBackgroundColor;
      moneyOutButton = const Color.fromRGBO(255, 88, 88, 80);
      moneyOutFontWeight = FontWeight.bold;
      moneyInFontWeight = FontWeight.normal;
      moneyOutText = primaryWhite;
      moneyInText = primaryGray;
      moneyInBorder = primaryGray;
      moneyOutBorder = primaryRed;
    }
  }

  //dropdown category
  void updateCategoryList(bool isMoneyIn) {
    if (isMoneyIn == true) {
      currentCategoryList = incomeList;
    } else {
      currentCategoryList = expensesList;
    }
  }

  void saveTransaction() {
    if (moneyformKey.currentState!.validate()) {
      String id = '${widget.updateID}';
      String description = descriptionController.text;
      double amount = double.parse(amountController.text);
      String date = dateController.text;
      String category = categoryValue;
      String payment = dropdownValue;

      try {
        firestoreService.updateTransaction(
            id, description, amount, date, category, payment);
        descriptionController.clear();
        amountController.clear();
        dateController.text = DateFormat('MM-dd-yyyy').format(DateTime.now());
        Navigator.pushNamed(context, 'splashUpdate');
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.popAndPushNamed(context, 'transact');
        });
      } on Exception catch (e) {
        Navigator.pop(context);
        print(e);
        // TODO
      }
    }
  }

  void transactionSucces(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Success()));
  }

  //text controllers
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //track the visibility of the second button
  bool isExpenseButtonVisible = false;
  bool isIncomeButtonVisible = true;

  //text state
  FontWeight moneyInFontWeight = FontWeight.normal;
  FontWeight moneyOutFontWeight = FontWeight.normal;

  //formKey
  final moneyformKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('MM-dd-yyyy').format(DateTime.now());
    updateStream = FirebaseFirestore.instance
        .collection("transaction")
        .doc(widget.updateID)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: primaryWhite,
          ),
          title: const Text('Back', style: TextStyle(color: primaryWhite)),
        ),
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
                        saveTransaction();
                      },
                      label: Text(
                        'Save',
                        style: GoogleFonts.inter(
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
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
                        Navigator.pop(context);
                      },
                      label: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: primaryWhite),
                      ),
                      backgroundColor: primaryGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(95)),
                    ),
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: updateStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No data available'));
                } else {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  descriptionController.text = data['description'];
                  amountController.text = data['amount'].toString();
                  currentDate = data['date']; 
                  String category = data['category'];
                  categoryValue = category;
                  String payment = data['payment'];
                  dropdownValue = payment;
                  String type = data['type'];

                  if (type == 'Income') {
                    buttonState(true);
                    updateCategoryList(true);
                  } else {
                    buttonState(false);
                    updateCategoryList(false);
                  }
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Money In Button
                        SizedBox(
                          width: 190,
                          height: 54,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: moneyInButton,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                                side: BorderSide(
                                  color: moneyInBorder,
                                )),
                            onPressed: () {},
                            child: Text(
                              "Money In",
                              style: TextStyle(
                                  color: moneyInText,
                                  fontWeight: moneyInFontWeight),
                            ),
                          ),
                        ),

                        //Money out Button
                        SizedBox(
                          width: 190,
                          height: 54,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                backgroundColor: moneyOutButton,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                side: BorderSide(
                                  color: moneyOutBorder,
                                )),
                            child: Text(
                              "Money Out",
                              style: TextStyle(
                                  color: moneyOutText,
                                  fontWeight: moneyOutFontWeight),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    //-------- DESCRIPTION ----------
                    Form(
                      key: moneyformKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Description",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryGreen,
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryRed,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    fontSize: 32,
                                    color: primaryWhite,
                                    fontWeight: FontWeight.w700),
                                decoration: const InputDecoration(
                                  hintText: "Enter Description",
                                  hintStyle: TextStyle(
                                      color: primaryGray,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w100,
                                      fontSize: 32),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //-------- AMOUNT -----------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Amount",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryGreen,
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryRed,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                controller: amountController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: primaryWhite,
                                    fontWeight: FontWeight.w700),
                                decoration: const InputDecoration(
                                  hintText: "0.00",
                                  hintStyle: TextStyle(
                                      color: primaryGray,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //-------- DATE -----------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Date",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryGreen,
                                    ),
                                  ),
                                  Text(
                                    "*",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryRed,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                controller: dateController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },

                                // readOnly: true,
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: primaryWhite,
                                    fontWeight: FontWeight.w700),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.date_range_rounded,
                                    color: primaryWhite,
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('MM-dd-yyyy')
                                            .format(pickedDate);

                                    dateController.text = formattedDate;

                                    String newDate = formattedDate;

                                    print(newDate);

                                    setState(() {
                                      dateController.text = newDate;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    //-------- CATEGORY -----------

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Category",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  DropdownButton<String>(
                                    value: categoryValue,
                                    dropdownColor: mobileBackgroundColor,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    style: const TextStyle(
                                        color: primaryGray, fontSize: 24),
                                    onChanged: (String? newValue) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        categoryValue = newValue!;
                                      });
                                      if (kDebugMode) {
                                        print(categoryValue);
                                      }
                                    },
                                    items: currentCategoryList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                const TextStyle(fontSize: 24)),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    //-------- MOP -----------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Mode of Payment",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    dropdownColor: mobileBackgroundColor,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    style: const TextStyle(
                                        color: primaryGray, fontSize: 24),
                                    onChanged: (String? newValue) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: paymentList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                const TextStyle(fontSize: 24)),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                );
              }),
        ));
  }
}
