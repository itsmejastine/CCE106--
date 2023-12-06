import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ViewGoal extends StatefulWidget {
  const ViewGoal({super.key});
  @override
  State<ViewGoal> createState() => _ViewGoalState();
}

class _ViewGoalState extends State<ViewGoal> {
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  color: primaryGray,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  color: primaryRed,
                )
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                GradientText(
                  '80 %',
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 64,
                      fontWeight: FontWeight.w700),
                  colors: [gradientGreen, gradientYellow],
                ),
                const SizedBox(height: 8),
                GradientText(
                  'You are almost there!',
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  colors: [gradientGreen, gradientYellow],
                )
              ],
            ),
            const SizedBox(height: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Goal",
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.displaySmall,
                    fontSize: 16,
                    color: primaryWhite,
                  ),
                ),
                const SizedBox(height: 8),
                Form(
                  child: TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "New Laptop",
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
                    Icon(
                      Icons.date_range,
                      color: primaryGreen,
                    ),
                    Text(
                      "Duration",
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 16,
                        color: primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Form(
                  child: TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "December 25, 2023",
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
                    Icon(
                      Icons.flag,
                      color: primaryYellow,
                    ),
                    Text(
                      "Target Ammount",
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 16,
                        color: primaryYellow,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Form(
                  child: TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Php 20,000.00",
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
            const SizedBox(height: 48),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Enter Amount Saved",
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 16,
                        color: primaryWhite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.add_box,
                        color: primaryGray,
                      ),
                      hintText: "Php 16,000.00",
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
