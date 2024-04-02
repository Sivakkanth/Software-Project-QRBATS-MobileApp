import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:qrbats_sp/api_config/api_constants.dart';
import 'package:qrbats_sp/widgets/snackbar/custom_snackbar.dart';


class MarkAttendanceService{
  static Future<bool> markAttendance(
      int eventID,
      int attendeeID,
      double locationGPSLatitude,
      double locationGPSLongitude,
      BuildContext context
      ) async {
    final Uri apiUrl = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.markAttendanceEndpoint}');
    Map<String, dynamic> attendanceData = {
      "eventID": eventID,
      "attendeeID": attendeeID,
      "attendanceDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "attendanceTime": DateFormat('HH:mm:ss').format(DateTime.now()),
      "locationGPSLatitude": locationGPSLatitude,
      "locationGPSLongitude": locationGPSLongitude
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
        CustomSnackBar.showSnackBar(context, "Attendance marked successfully.");
        return true;

      } else {
        // Registration failed
        CustomSnackBar.showSnackBar(context, "Failed to mark attendance.");
        print('Failed to mark attendance: ${response.statusCode}');
        // Handle error
        return false;
      }
    } catch (error) {
      // Catch any errors that occur during the HTTP request
      CustomSnackBar.showSnackBar(context, "Error in marking attendance.");
      print('Error in marking attendance: $error');
      return false;
    }
  }
}