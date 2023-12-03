import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:flutter_it14proj/splash%20pages/success.dart';
import 'package:google_fonts/google_fonts.dart';

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

class MoneyIn extends StatefulWidget {
  const MoneyIn({super.key});

  @override
  State<MoneyIn> createState() => _MoneyInState();
}

class _MoneyInState extends State<MoneyIn> {
  //firestore
  final FirestoreService firestorService = FirestoreService();

  //Calling dropdown
  String dropdownValue = paymentList.first;
  String categoryValue = incomeList.first;
  List<String> currentCategoryList = incomeList;

  void updateCategoryList(bool isMoneyIn) {
    setState(() {
      if (isMoneyIn == true) {
        currentCategoryList = incomeList;
        if (!incomeList.contains(categoryValue)) {
          categoryValue = incomeList.first;
        }
      } else {
        currentCategoryList = expensesList;
        if (!expensesList.contains(categoryValue)) {
          categoryValue = expensesList.first;
        }
      }
    });
  }

  //text controllers
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //track the visibility of the second button
  bool isExpenseButtonVisible = false;
  bool isIncomeButtonVisible = true;

  //text state
  FontWeight moneyInFontWeight = FontWeight.w700;
  FontWeight moneyOutFontWeight = FontWeight.normal;

  //formKey
  final moneyformKey = GlobalKey<FormState>();

  //Function to navigate to the success.dart
  void TransactionSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Success()),
    );

    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Money In Button
                  SizedBox(
                    width: 190,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          moneyInButton = Color.fromRGBO(21, 160, 39, 80);
                          moneyOutButton = mobileBackgroundColor;
                          moneyInText = primaryWhite;
                          moneyOutText = primaryGray;
                          moneyInBorder = primaryGreen;
                          moneyOutBorder = primaryGray;
                          moneyInFontWeight = FontWeight.bold;
                          moneyOutFontWeight = FontWeight.normal;
                          isExpenseButtonVisible = false;
                          isIncomeButtonVisible = true;
                          updateCategoryList(true);
                        });
                      },
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
                      child: Text(
                        "Money In",
                        style: TextStyle(
                            color: moneyInText, fontWeight: moneyInFontWeight),
                      ),
                    ),
                  ),

                  //Money out Button
                  SizedBox(
                    width: 190,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          moneyInButton = mobileBackgroundColor;
                          moneyOutButton = Color.fromRGBO(255, 88, 88, 80);
                          moneyOutFontWeight = FontWeight.bold;
                          moneyInFontWeight = FontWeight.normal;
                          moneyOutText = primaryWhite;
                          moneyInText = primaryGray;
                          moneyInBorder = primaryGray;
                          moneyOutBorder = primaryRed;
                          isExpenseButtonVisible = !isExpenseButtonVisible;
                          isIncomeButtonVisible = !isIncomeButtonVisible;
                          updateCategoryList(false);
                        });
                      },
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
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryGreen,
                              ),
                            ),
                            Text(
                              "*",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
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
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryGreen,
                              ),
                            ),
                            Text(
                              "*",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
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
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                fontSize: 16,
                                color: primaryGreen,
                              ),
                            ),
                            Text(
                              "*",
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displaySmall,
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
                          style: const TextStyle(
                              fontSize: 24,
                              color: primaryWhite,
                              fontWeight: FontWeight.w700),
                          decoration: const InputDecoration(
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
                          textStyle: Theme.of(context).textTheme.displaySmall,
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
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  categoryValue = value!;
                                });
                              },
                              items: currentCategoryList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(fontSize: 24)),
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
                          textStyle: Theme.of(context).textTheme.displaySmall,
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
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: paymentList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(fontSize: 24)),
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

              //income button
              Visibility(
                visible: isIncomeButtonVisible,
                child: Center(
                  child: SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (moneyformKey.currentState!.validate()) {
                          String description = descriptionController.text;
                          double amount = double.parse(amountController.text);
                          String date = dateController.text;
                          String category = categoryValue;
                          String payment = dropdownValue;
                          String type = "Income";
                          firestorService.addTransaction(description, amount,
                              date, category, payment, type);

                          descriptionController.clear();
                          amountController.clear();
                          dateController.clear();
                        }
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
              ),

              //Expenses Button
              Visibility(
                visible: isExpenseButtonVisible,
                child: Center(
                  child: SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (moneyformKey.currentState!.validate()) {
                          String description = descriptionController.text;
                          double amount = double.parse(amountController.text);
                          String date = dateController.text;
                          String category = categoryValue;
                          String payment = dropdownValue;
                          String type = "Expenses";
                          firestorService.addTransaction(description, amount,
                              date, category, payment, type);

                          descriptionController.clear();
                          amountController.clear();
                          dateController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        elevation: 0,
                      ),
                      child: const Text(
                        "Add Expense",
                        style: TextStyle(color: primaryWhite, fontSize: 20),
                      ),
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
