import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_config/api_constants.dart';
import '../widgets/snackbar/custom_snackbar.dart';

class CheckStudentInfo {
  static Future<void> checkStudentInfo(
      String email,
      String indexNo,
      Function function,
      BuildContext context,
      ) async {
    final Uri apiUrlEmail =
    Uri.parse('${ApiConstants.mobileBaseUrl}${ApiConstants.checkStudentEmailEndpoint}');
    final Uri apiUrlIndexNo =
    Uri.parse('${ApiConstants.mobileBaseUrl}${ApiConstants.checkStudentIndexNoEndpoint}');
    Map<String, dynamic> emailData = {
      'studentEmail': email,
    };
    Map<String, dynamic> indexNoData = {
      'studentIndexNo': indexNo,
    };

    try {
      final List<http.Response> responses = await Future.wait([
        http.post(
          apiUrlEmail,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(emailData),
        ),
        http.post(
          apiUrlIndexNo,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(indexNoData),
        ),
      ]);

      final bool emailExists =
          responses[0].statusCode == 200 && responses[0].body == "true";
      final bool indexNoExists =
          responses[1].statusCode == 200 && responses[1].body == "true";

      if (emailExists && indexNoExists) {
        CustomSnackBar.showSnackBar(
            context, 'The email address and index number already exist.');
      } else if (emailExists) {
        CustomSnackBar.showSnackBar(
            context, 'The email address already exists.');
      } else if (indexNoExists) {
        CustomSnackBar.showSnackBar(
            context, 'The index number already exists.');
      } else {
        function();
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
