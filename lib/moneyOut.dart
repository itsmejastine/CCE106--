import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MoneyOut extends StatefulWidget {
  const MoneyOut({super.key});

  @override
  State<MoneyOut> createState() => _MoneyOutState();
}

class _MoneyOutState extends State<MoneyOut> {
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
                        // backgroundColor: Color.fromRGBO(21, 160, 39, 80),
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
                        backgroundColor: Color.fromRGBO(255, 88, 88, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                        side: const BorderSide(
                          color: primaryRed,
                        )),
                    child: const Text(
                      "Money Out",
                      style: TextStyle(color: primaryRed),
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
                    decoration: InputDecoration(
                      hintText: "Jollibee",
                      hintStyle: TextStyle(
                          color: primaryWhite,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
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
                    decoration: InputDecoration(
                      hintText: "Php 150.00",
                      hintStyle: TextStyle(
                          color: primaryWhite,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
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
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.date_range_rounded,
                        color: primaryWhite,
                      ),
                      hintText: "November 20, 2023",
                      hintStyle: TextStyle(
                          color: primaryWhite,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
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
                    decoration: InputDecoration(
                      hintText: "Food",
                      hintStyle: TextStyle(
                          color: primaryWhite,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
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
                      "Mode of Payemnt",
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
                    decoration: InputDecoration(
                      hintText: "Cash",
                      hintStyle: TextStyle(
                          color: primaryWhite,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
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
                        Navigator.pushNamed(context, 'loginPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        elevation: 0,
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: primaryWhite, fontSize: 20),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 54,
                    width: 190,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'loginPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGray,
                        elevation: 0,
                      ),
                      child: const Text(
                        "Cancel",
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
    );
  }
}
