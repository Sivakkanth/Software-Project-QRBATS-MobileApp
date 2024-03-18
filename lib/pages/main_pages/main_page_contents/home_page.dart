import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../components/buttons/button_dark_small.dart';
import '../../../components/texts/TextBlue.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "";
  bool showQRCodeDetails = false;
  double latitude = 0.0;
  double longitude = 0.0;

  // Location
  /*Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Request location permission
    var status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle denied permissions
      setState(() {
        latitude = 0.0;
        longitude = 0.0;
      });
      return;
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      setState(() {
        latitude = 0.0;
        longitude = 0.0;
      });
      return;
    }

    // Check if permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied
      setState(() {
        latitude = 0.0;
        longitude = 0.0;
      });
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      setState(() {
        latitude = 0.0;
        longitude = 0.0;
      });
      return;
    }

    // When we reach here, permissions are granted and location services are enabled
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }*/


  Future<void> scanQRCode() async {
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "cancel",
        true,
        ScanMode.QR,
      );
      debugPrint(result);
    } on PlatformException {
      result = "not scan";
    }
    if (!mounted) return;
    print("THE RESULT IS $result");
    setState(() {
      showQRCodeDetails = true;
    });
    //findLocation();
  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    //double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              TextBlue(
                text: "Scan QR Code to Mark Attendance",
                fontSize: 20,
              ),
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF086494),
                      width: 3.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF086494),
                      width: 3.0,
                    ),
                    left: BorderSide(
                      color: Color(0xFF086494),
                      width: 3.0,
                    ),
                    right: BorderSide(
                      color: Color(0xFF086494),
                      width: 3.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("lib/assets/qrcode/qrcode.png"),
                    height: screenHeight * 0.3,
                  ),
                ),
              ),
              SizedBox(height: 30),
              MyButtonDS(onTap: scanQRCode, text: "Scan QR Code", width: 200),
              MyButtonDS(onTap: (){}, text: "find location", width: 200),
              SizedBox(height: 10),
              Column(
                children: [
                  Text("QRCode Details"),
                  SizedBox(
                    height: 10,
                  ),
                  if (showQRCodeDetails)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Event Name : "),
                            Text(result.split(', ')[0] ?? ""),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Module : "),
                            Text(result.split(', ')[1] ?? ""),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Date : "),
                            Text(result.split(', ')[2] ?? ""),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Time : "),
                            Text(result.split(', ')[3] ?? ""),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Venue : "),
                            Text(result.split(', ')[4] ?? ""),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("latitude : "),
                            Text(latitude.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("longitude : "),
                            Text(longitude.toString()),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyButtonDS(
                            onTap: (){},
                            text: "Mark Attendance",
                            width: 200)
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
