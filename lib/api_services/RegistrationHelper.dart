import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api_config/api_constants.dart';
import '../pages/login_signup_pages/login_page.dart';

class RegistrationHelper {
  static const String mobileBaseUrl = ApiConstants.mobileBaseUrl;
  static const String studentRegisterEndpoint = ApiConstants.studentRegister;
  static const String checkStudentUserNameEndpoint =
      ApiConstants.checkStudentUserNameEndpoint;

  static Future<void> register(
      BuildContext context,
      String username,
      String password,
      String studentName,
      String indexNumber,
      String email,
      String studentRole,
      int departmentId,
      int currentSemester,
      ) async {
    final Uri apiUrlSignup = Uri.parse('$mobileBaseUrl$studentRegisterEndpoint');
    final Uri apiUrlCheckUserName =
    Uri.parse('$mobileBaseUrl$checkStudentUserNameEndpoint');

    Map<String, dynamic> userData = {
      'userName': username,
      'password': password,
      'studentName': studentName,
      'indexNumber': indexNumber,
      'studentEmail': email,
      'studentRole': studentRole,
      'departmentId': departmentId,
      'currentSemester': currentSemester,
    };

    try {
      final http.Response checkUserNameResponse = await http.post(
        apiUrlCheckUserName,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'studentUserName': username}),
      );
      print(checkUserNameResponse.body);

      if (checkUserNameResponse.statusCode == 200) {
        final bool usernameExists = jsonDecode(checkUserNameResponse.body);
        if (!usernameExists) {
          final http.Response registerResponse = await http.post(
            apiUrlSignup,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(userData),
          );

          if (registerResponse.statusCode == 200) {
            // Registration successful
            print("Student registered successfully");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          } else {
            // Registration failed
            print('Failed to register user: ${registerResponse.statusCode}');
            // Handle error
          }
        } else {
          // Username already exists, show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xFF086494),
              content: Text('The User Name already exists.'),
            ),
          );
        }
      } else {
        // Handle error if failed to check username
        print(
            'Failed to check username existence: ${checkUserNameResponse.statusCode}');
        // Handle error
      }
    } catch (error) {
      // Catch any errors that occur during the HTTP request
      print('Error registering user: $error');
      // Handle error
    }
  }
}
