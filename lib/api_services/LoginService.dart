import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_config/api_constants.dart';
import '../../pages/main_pages/main_page.dart';
import '../widgets/snackbar/custom_snackbar.dart'; // Import CustomSnackBar class

class LoginService {
  static Future<void> login(BuildContext context, String username, String password) async {
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();

    final Uri apiUrl = Uri.parse('${ApiConstants.mobileBaseUrl}${ApiConstants.studentlogin}');
    final Map<String, dynamic> userData = {
      'studentUserName': username,
      'password': password,
    };

    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var myToken = jsonResponse['token'];
        print(myToken);
        preferences.setString("token", myToken);
        CustomSnackBar.showSnackBar(context, 'Welcome To SkyTicker.'); // Use CustomSnackBar
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MainPage(token: myToken);
          }),
        );
      } else {
        CustomSnackBar.showSnackBar(context, 'Please check user name or password.'); // Use CustomSnackBar
      }
    } catch (error) {
      // Catch any errors that occur during the HTTP request
      print('Error registering user: $error');
    }
  }
}
