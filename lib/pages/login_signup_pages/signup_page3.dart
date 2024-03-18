import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../components/buttons/button_dark_small.dart';
import '../../components/buttons/round_button.dart';
import '../../components/text_field/text_field.dart';
import '../../components/texts/TextBlue.dart';
import '../main_pages/main_page.dart';

class SignUp3 extends StatefulWidget {
  final String studentName;
  final String indexNumber;
  final String email;
  final String studentRole;
  final int departmentId;
  final int currentSemester;

  const SignUp3({
    Key? key,
    required this.studentName,
    required this.indexNumber,
    required this.email,
    required this.studentRole,
    required this.departmentId,
    required this.currentSemester,
  }) : super(key: key);

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  void previousPage() {
    Navigator.pop(context);
  }

  void nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MainPage();
      }),
    );
  }

  /*void testPrint(String username,
      String password,
      String studentName,
      String indexNumber,
      String email,
      String studentRole,
      int departmentId,
      int currentSemester,){
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
  }*/
  //final Uri apiUrlRegister = Uri.parse("http://10.0.2.2:8080/api/v1/auth/mobileregister");

  /*Future registerUser(
      String username,
      String password,
      String studentName,
      String indexNumber,
      String email,
      String studentRole,
      int departmentId,
      int currentSemester,
      ) async {

    try {
      var response = await http.post(
          apiUrlRegister,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'userName': username,
            'password': password,
            'studentName': studentName,
            'indexNumber': indexNumber,
            'studentEmail': email,
            'studentRole': studentRole,
            'departmentId': 2,
            'currentSemester': 6,
          }));
      print(response.body);
    } on Exception catch (e) {
      print(e);
    }
  }*/

  Future<void> register(
    String username,
    String password,
    String studentName,
    String indexNumber,
    String email,
    String studentRole,
    int departmentId,
    int currentSemester,
  ) async {
    final Uri apiUrl =
        Uri.parse('http://192.168.1.11:8080/api/v1/mobile/signup');

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
    print(userData);

    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        // Registration successful
        print("Student registered successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MainPage();
          }),
        );
        print(response.body);
      } else {
        // Registration failed
        print('Failed to register user: ${response.statusCode}');
        // Handle error
      }
    } catch (error) {
      // Catch any errors that occur during the HTTP request
      print('Error registering user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            children: [
              SizedBox(height: 25),
              Center(child: TextBlue(text: "SignUp", fontSize: 30)),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: screenHeight * 0.65,
                  width: screenWidth * 0.9,
                  decoration: _buildContainerDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "This is very easy to use and You can mark your attendance very Quickly and Easily",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ),
                        TextBlue(text: "2.Student Account", fontSize: 25),
                        SizedBox(height: 30),
                        TextBlue(text: "User Name", fontSize: 20),
                        SizedBox(height: 10),
                        MyTextField(
                          controller: _userNameTextController,
                          hintText: "user name",
                          width: screenWidth * 0.8,
                          obscureText: false,
                          icon: Icon(Icons.person),
                        ),
                        SizedBox(height: 40),
                        TextBlue(text: "Password", fontSize: 20),
                        SizedBox(height: 10),
                        MyTextField(
                          controller: _password,
                          hintText: "password",
                          width: screenWidth * 0.8,
                          obscureText: true,
                          icon: Icon(Icons.lock),
                        ),
                        SizedBox(height: 40),
                        TextBlue(text: "Confirm Password", fontSize: 20),
                        SizedBox(height: 10),
                        MyTextField(
                          controller: _confirmPassword,
                          hintText: "confirm password",
                          width: screenWidth * 0.8,
                          obscureText: true,
                          icon: Icon(Icons.lock),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    RoundButton(onTap: previousPage, icon: Icons.arrow_back),
                    Spacer(),
                    MyButtonDS(
                      onTap: () => register(
                          _userNameTextController.text,
                          _password.text,
                          widget.studentName,
                          widget.indexNumber,
                          widget.email,
                          widget.studentRole,
                          widget.departmentId,
                          widget.currentSemester),
                      text: "SignUp",
                      width: 100,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        top: BorderSide(
          color: Color(0xFF086494),
          width: 6.0,
        ),
        bottom: BorderSide(
          color: Color(0xFF086494),
          width: 1.0,
        ),
        left: BorderSide(
          color: Color(0xFF086494),
          width: 1.0,
        ),
        right: BorderSide(
          color: Color(0xFF086494),
          width: 1.0,
        ),
      ),
    );
  }
}
