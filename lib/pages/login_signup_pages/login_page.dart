import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qrbats_sp/pages/getStart_page.dart';
import 'package:qrbats_sp/pages/login_signup_pages/forgot_password_page.dart';
import 'package:qrbats_sp/pages/login_signup_pages/signup_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_config/api_constants.dart';
import '../../api_services/LoginService.dart';
import '../../components/buttons/button_dark_large.dart';
import '../../components/buttons/round_button.dart';
import '../../components/text_field/text_field.dart';
import '../../components/texts/TextBlue.dart';
import '../main_pages/main_page.dart';



class Login extends StatefulWidget {


  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
  }
  Future<void> initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void previousPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return OpennigPage();
      }),
    );
  }

  void forgotPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ForgotPasswordPage();
      }),
    );
  }

  void signUpPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return Signup1();
        }));
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
              Center(child: TextBlue(text: "LogIn", fontSize: 30)),
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
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ),
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
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(onPressed: forgotPasswordPage, child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF086494),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF086494), // Optional: specify underline color
                                decorationStyle: TextDecorationStyle.solid, // Optional: specify underline style
                              ),)),
                            SizedBox(width: 15,),
                          ],

                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              "If you don't have an account? ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                            TextButton(onPressed: signUpPage, child: Text("SignUp", style: TextStyle(color: Color(0xFF086494)),)),
                            Spacer(),
                          ],
                        ),
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
                      onTap: () => LoginService.login(
                        context,
                        _userNameTextController.text,
                        _password.text,
                      ),
                      text: "LogIn",
                      width: screenWidth * 0.35,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              SizedBox(height: screenHeight*0.05,),
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
