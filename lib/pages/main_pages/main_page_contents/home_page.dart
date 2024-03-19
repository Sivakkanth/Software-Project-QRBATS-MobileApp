import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle case when location permission is denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle case when location permission is permanently denied
      return;
    }

    getLocation(); // Permission granted, get the location
  }



  Future<void> scanQRCode() async {
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "cancel",
        true,
        ScanMode.QR,
      );
      debugPrint(result);
      setState(() {
        showQRCodeDetails = true;
      });
    } on PlatformException {
      result = "not scan";
    }
    if (!mounted) return;
    print("THE RESULT IS $result");

    //findLocation();
  }



  Future<void> markAttendance(
      int eventID,
      int attendeeID,
      double locationX,
      double locationY
      ) async {
    final Uri apiUrl = Uri.parse('http://192.168.1.11:8080/api/v1/attendance/markattendance');
    Map<String, dynamic> attendanceData = {
      "eventID": eventID,
      "attendeeID": attendeeID,
      "attendanceDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "attendanceTime": DateFormat('HH:mm:ss').format(DateTime.now()),
      "locationX": locationX,
      "locationY": locationY
    };
    print(attendanceData);

    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(attendanceData),
      );

      if (response.statusCode == 200) {
        // Registration successful
        print("Attendance marked successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Attendance marked successfully.'
              )
          ),
        );
        setState(() {
          showQRCodeDetails = false;
        });

        print(response.body);
      } else {
        // Registration failed
        print('Failed to mark attendance: ${response.statusCode}');
        // Handle error
      }
    } catch (error) {
      // Catch any errors that occur during the HTTP request
      print('Error in marking attendance: $error');
    }
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
                    height: screenHeight * 0.1,
                  ),
                ),
              ),
              SizedBox(height: 30),
              MyButtonDS(onTap:(){
                checkLocationPermission();
                scanQRCode();
              } , text: "Scan QR Code", width: 200),
              SizedBox(height: 10,),
              MyButtonDS(onTap: (){checkLocationPermission();}, text: "Check Location", width: 200),
              SizedBox(height: 10),
              Column(
                children: [
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
                    height: 20,
                  ),
                  if (showQRCodeDetails)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("QRCode Details"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
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

                        SizedBox(
                          height: 10,
                        ),
                        MyButtonDS(
                            onTap: (){markAttendance(10,20,latitude,longitude);},
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
