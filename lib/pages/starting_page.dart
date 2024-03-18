import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'getStart_page.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  void initState() {
    super.initState();

    // Add a delay and then navigate to the next page
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OpennigPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: h / 5,
                //width: w,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    "W E L C O M E",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF086494)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  height: h / 2.5,
                  width: w*0.8,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/assets/logo/logo.png"))),
                ),
              ),
              Container(
                height: h / 3,
                width: w,
                decoration: BoxDecoration(
                    color: Color(0xFF086494),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    Lottie.asset('lib/assets/loading/loading1.json',
                        width: 200, height: 200, fit: BoxFit.fill),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 40,
                        left: 40,
                      ),
                      child: Text(
                        "This is the best app to take attendance using QR code with GPS tracking",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
