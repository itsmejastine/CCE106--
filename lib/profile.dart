import 'package:flutter/material.dart';
import 'package:flutter_it14proj/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 74, 16, 74),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.logout, color: primaryRed),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                    child: Text(
                      'Logout',
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: primaryRed,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => launchUrlString('welcomePage'))
              ],
            ),
            SizedBox(
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
                    Text(
                      "Username",
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayMedium,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: primaryWhite,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: primaryGray,
                        ))
                  ],
                ),
                SizedBox(
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
                            textStyle: Theme.of(context).textTheme.displaySmall,
                            fontSize: 16,
                            color: textGreen,
                          ),
                        ),
                        Text(
                          "PHP 100,000.00",
                          style: GoogleFonts.inter(
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: textGreen,
                          ),
                        ),
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
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: primaryGray,
                                    ))
                              ],
                            ),
                            Text(
                              "test@email.com",
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
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
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
    );
  }
}
