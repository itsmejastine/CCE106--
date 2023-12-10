import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it14proj/components/colors.dart';
import 'package:flutter_it14proj/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //logout user method
  void logout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: mobileBackgroundColor,
              title: const Icon(
                Icons.logout,
                color: primaryRed,
                size: 108,
              ),
              content: Text(
                'Are you sure to leave your companion?',
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  fontSize: 16,
                  color: primaryWhite,
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
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
                    child: const Text("No, I'll stay"),
                  ),
                )
              ]);
        });
  }

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 74, 16, 74),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Logout Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: logout,
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: primaryRed,
                      ),
                      label: const Text(
                        'Logout',
                        style: TextStyle(color: primaryRed),
                      )),
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
                  //USERNAME

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                        future: firestoreService.getUserDetails(),
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
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),

                  //BALANCE

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
                            future: firestoreService.getUserDetails(),
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

                  //EMAIL
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
                                const SizedBox(
                                  height: 8,
                                ),
                                Flexible(
                                    child: FutureBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                  future: firestoreService.getUserDetails(),
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

                      //PASSWORD

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
                              Text(
                                "password",
                                style: GoogleFonts.inter(
                                  textStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  fontSize: 16,
                                  color: primaryWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
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
