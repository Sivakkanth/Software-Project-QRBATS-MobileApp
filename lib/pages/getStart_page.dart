import 'package:flutter/material.dart';

import '../components/buttons/button_white.dart';
import 'login_signup_pages/signup_page1.dart';

class OpennigPage extends StatefulWidget {
  const OpennigPage({super.key});

  @override
  State<OpennigPage> createState() => _OpennigPageState();
}

class _OpennigPageState extends State<OpennigPage> {
  void getStart() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Signup1();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final themeColour = Color(0xFF086494);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    "W E L C O M E",
                    style: TextStyle(
                        color: themeColour,
                        fontSize: screenHeight * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Image(
                  image: AssetImage("lib/assets/logo/logo.png"),
                  height: screenHeight * 0.3,
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: themeColour,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                    ),
                  ),
                  //color: Colors.white,
                  height: screenHeight * 0.3,
                  child: Center(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 40, bottom: 25, left: 30, right: 35),
                        child: Text(
                            "This is the best app to take Attendance using QR code with GPS tracking",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                      Container(
                          child: MyButtonWhite(
                        onTap: getStart,
                        text: "Get Start",
                        width: screenWidth * 0.6,
                      )),
                    ],
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ));
  }
}
