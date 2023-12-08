import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //logout user method
  void logUserOut() {
    FirebaseAuth.instance.signOut();
  }

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 74, 16, 74),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.logout, color: primaryRed),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: logUserOut,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mobileBackgroundColor,
                        foregroundColor: primaryRed),
                    child: const Text("Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(-0.53, 0.85),
                                  end: Alignment(0.53, -0.85),
                                  colors: <Color>[
                                Color(0xFF14A026),
                                Color(0xFFF0DA11)
                              ])),
                          //   child: Image.asset(
                          //    '../lib/image/pic.jpg',
                          //    fit: BoxFit.fitWidth,
                          //  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                        future: getUserDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            Map<String, dynamic>? user = snapshot.data!.data();

                            return Text(
                              user!['username'],
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displayMedium,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: primaryWhite,
                              ),
                            );
                          } else {
                            return const Text("No data");
                          }
                        },
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: primaryGray,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    height: 64,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                            begin: Alignment(-0.53, 0.85),
                            end: Alignment(0.53, -0.85),
                            colors: <Color>[
                              Color(0xFF14A026),
                              Color(0xFFF0DA11)
                            ])),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balance",
                            style: GoogleFonts.inter(
                              textStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              fontSize: 16,
                              color: textGreen,
                            ),
                          ),
                          Flexible(
                              child: FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                            future: getUserDetails(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  "Calculating ...",
                                  style: GoogleFonts.inter(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: textGreen,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                Map<String, dynamic>? user =
                                    snapshot.data!.data();

                                return Text(
                                  "Php  ${user!['balance']}",
                                  style: GoogleFonts.inter(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: textGreen,
                                  ),
                                );
                              } else {
                                return const Text("No data");
                              }
                            },
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: secondaryGreen),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "email",
                                      style: GoogleFonts.inter(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                        fontSize: 16,
                                        color: primaryWhite,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit,
                                          color: primaryGray,
                                        ))
                                  ],
                                ),
                                Flexible(
                                    child: FutureBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                  future: getUserDetails(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else if (snapshot.hasData) {
                                      Map<String, dynamic>? user =
                                          snapshot.data!.data();

                                      return Text(
                                        user!['email'],
                                        style: GoogleFonts.inter(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: primaryWhite,
                                        ),
                                      );
                                    } else {
                                      return const Text("No data");
                                    }
                                  },
                                )),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: secondaryGreen),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "password",
                                    style: GoogleFonts.inter(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      fontSize: 16,
                                      color: primaryWhite,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: primaryGray,
                                      ))
                                ],
                              ),
                              Text(
                                "..........",
                                style: GoogleFonts.inter(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: primaryWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
