import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class Netflix extends StatefulWidget {
  const Netflix({super.key});

  @override
  State<Netflix> createState() => _NetflixState();
}

class _NetflixState extends State<Netflix> {
  bool _isHovering = false;

  void hover() {
    print("hovering");

    if (_isHovering) {
      Positioned(
        top: 100,
        left: 100,
        child: Container(height: 150, width: 50, color: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const SizedBox(width: 42),

            Text(
              "Netflix",
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),

            const SizedBox(width: 45),
            Text(
              "Home",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "Characters",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "Shows",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "Movies",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "New & popular",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "My list",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Text(
              "Browse by languages",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const Spacer(),
            Icon(Icons.search, color: Colors.white, size: 30),
            const SizedBox(width: 16),
            Text(
              "Children",
              style: GoogleFonts.openSans(color: Colors.white, fontSize: 13),
            ),
            const SizedBox(width: 16),
            const Icon(CupertinoIcons.bell, color: Colors.white, size: 24.0),
            const SizedBox(width: 15),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(5),
              child: Image.asset("images/8.png", width: 30),
            ),
            const SizedBox(width: 5),
            Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 2000,
              width: double.infinity,
              color: const Color.fromARGB(255, 20, 20, 20),
              child: Stack(
                children: [
                  Container(
                    height: 700,
                    width: double.infinity,
                    color: Colors.red,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            "images/snowpiercer_back.webp",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(
                                    0.1,
                                  ), // Lightest fade at the top
                                  const Color.fromARGB(
                                    255,
                                    0,
                                    0,
                                    0,
                                  ), // Heaviest fade at the bottom
                                ],
                                stops: const [
                                  0.0,
                                  1.0,
                                ], // Start at 0% and end at 100%
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: 60,
                          top: 106,
                          child: Image.asset(
                            "images/snowpiercer.webp",
                            height: 240,
                          ),
                        ),
                        Positioned(
                          top: 362,
                          left: 60,
                          child: Text(
                            "Earth has frozen over and the last surviving humans live on a\ngiant train circling the globe, struggling to coexist amid the\ndelicate balance onboard.",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Positioned(
                          top: 450,
                          left: 60,
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 15),

                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                      size: 45,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Play",
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                height: 50,
                                width: 170,

                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    109,
                                    104,
                                    104,
                                  ),

                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "More info",
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /////////////////////////////////////////////////////////////////////////
                  //////////////////////////////////////////////////////////////
                  Positioned.fill(
                    top: 700,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color.fromARGB(
                              255,
                              20,
                              20,
                              20,
                            ).withOpacity(0.1), // Lightest fade at the top
                            const Color.fromARGB(
                              255,
                              0,
                              0,
                              0,
                            ), // Heaviest fade at the bottom
                          ],
                          stops: const [
                            0.6,
                            0.9,
                          ], // Start at 0% and end at 100%
                        ),
                      ),
                    ),
                  ),

                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  Positioned(
                    left: 60,
                    right: 0,
                    top: 630,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Because You Watched Queen Of Tears",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 140,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/0.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/2.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/5.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ////////////////////////////////////////
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/0.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/2.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/5.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  Positioned(
                    left: 60,
                    right: 0,
                    top: 860,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Next Watch",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 140,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/2.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/5.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/7.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ////////////////////////////////////////
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/2.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/5.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/7.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  Positioned(
                    left: 60,
                    right: 0,
                    top: 1100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Top 10 Shows In India Today",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 180,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/bye.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/hi.webp',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/no 2.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/22.jpg',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/no 3.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/33.jpg',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/bye.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/hi.webp',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/no 2.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/22.jpg',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/no 3.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/33.jpg',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/bye.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/hi.webp',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/no 2.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/22.jpg',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/no 3.png',
                                    height: 180,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/33.jpg',
                                    height: 180,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  Positioned(
                    left: 60,
                    right: 0,
                    top: 1370,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "K-Dramas Dubbed In Hindi",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 140,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/0.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/2.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/5.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ////////////////////////////////////////
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/0.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/2.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/5.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/1/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////
                  Positioned(
                    left: 60,
                    right: 0,
                    top: 1600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Only On Netflix",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 140,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/2.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/5.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/7.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ////////////////////////////////////////
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/1.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/2.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/3.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/4.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/5.webp',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/6.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                  child: Image.asset(
                                    'images/2/7.jpg',
                                    height: 140,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
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
