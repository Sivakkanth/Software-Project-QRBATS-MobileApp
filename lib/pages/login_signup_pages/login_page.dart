import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qrbats_sp/pages/getStart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/buttons/button_dark_small.dart';
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

  Future<void> login(String username, String password) async {
    await initSharedPreference(); // Wait for preferences to be initialized

    final Uri apiUrl = Uri.parse('http://192.168.1.11:8080/api/v1/mobile/signin');
    final Map<String, dynamic> userData = {
      'userName': username,
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
        // Registration successful
        var jsonResponse = jsonDecode(response.body);
        var myToken = jsonResponse['token'];
        print(myToken);
        preferences.setString("token", myToken);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Welcome To SkyTicker.'
              )
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MainPage(token: myToken);
          }),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'User name or password incorrect, or you dont have an account.'
              )
          ),
        );
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
                        TextBlue(text: "Student Login", fontSize: 25),
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
                      onTap: () => login(
                        _userNameTextController.text,
                        _password.text,
                      ),
                      text: "LogIn",
                      width: screenWidth*0.35,
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
