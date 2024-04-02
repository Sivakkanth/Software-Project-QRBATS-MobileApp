import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qrbats_sp/api_services/MerkAttendanceService.dart';
import 'package:qrbats_sp/components/buttons/button_dark_large.dart';
import 'package:qrbats_sp/components/buttons/button_dark_small.dart';
import 'package:qrbats_sp/components/texts/TextBlue.dart';
import 'package:qrbats_sp/models/QRCodeDetails.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';


class QRCodeScan extends StatefulWidget {
  final String token;
  const QRCodeScan({Key? key, this.token=""}) : super(key: key);

  @override
  State<QRCodeScan> createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan> {

  late int studentId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    studentId = jwtDecodedToken["studentId"];
  }


  String? result;
  QRCodeDetails? qrCodeDetails;
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


 /* // Replace this key with your decryption key (32 bytes for AES-256)

  QRCodeDetails? decryptQRCodeData(String encryptedData)  {
    final key = encrypt.Key.fromUtf8('uDhHvDXPKJUJSMVdx8JSYamDTu18iLTVTzg/Ohy05no=');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    qrCodeDetails = QRCodeDetails.fromJson(jsonDecode(decrypted));
    return qrCodeDetails;
    *//*setState(() {
      qrCodeDetails = QRCodeDetails.fromJson(jsonDecode(decrypted));
      showQRCodeDetails = true;
    });*//*
  }*/

  Future<void> scanQRCode() async {
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "cancel",
        true,
        ScanMode.QR,
      );
      debugPrint("Scanned QR Code: $result");
      if (result != null) {
        setState(() {
          try {
            setState(() {
              qrCodeDetails = QRCodeDetails.fromJson(jsonDecode(result!));
              showQRCodeDetails = true;
            });
          } catch (e) {
            debugPrint("Error parsing QR code data: $e");
          }
        });
      }
    } on PlatformException {
      result = "not scan";
    }
    if (!mounted) return;
    print("THE RESULT IS $result");
  }

  Future<void> markAttendance(
      int eventID, int attendeeID,double latitude, double longitude, BuildContext context) async {
    bool isCloseDetails = await MarkAttendanceService.markAttendance(
        eventID, attendeeID, latitude, longitude, context);
    if (isCloseDetails) {
      setState(() {
        showQRCodeDetails = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
              MyButtonDS(
                onTap: () {
                  checkLocationPermission();
                  scanQRCode();
                },
                text: "Scan QR Code",
                width: 200,
              ),
              SizedBox(height: 10),
              MyButtonSmall(
                onTap: () {
                  checkLocationPermission();
                },
                text: "Check Location",
                width: 150,
              ),
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
                  SizedBox(height: 20),
                  if (showQRCodeDetails && qrCodeDetails != null)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("QRCode Details"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Event Name : "),
                            Text(qrCodeDetails!.eventName),
                          ],
                        ),
                        if(qrCodeDetails!.moduleName != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Module : "),
                            Text(qrCodeDetails!.moduleName ?? ''),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Date : "),
                            Text(qrCodeDetails!.eventDate),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Time : "),
                            Text(qrCodeDetails!.eventTime),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Venue : "),
                            Text(qrCodeDetails!.eventVenue),
                          ],
                        ),
                        SizedBox(height: 10),
                        MyButtonDS(
                          onTap: () {
                            markAttendance(
                              qrCodeDetails!.eventId,
                              studentId,
                              latitude,
                              longitude,
                              context,
                            );
                          },
                          text: "Mark Attendance",
                          width: 200,
                        ),
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

