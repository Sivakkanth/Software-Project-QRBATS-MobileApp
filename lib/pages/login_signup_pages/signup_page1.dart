import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qrbats_sp/api_services/CheckStudentInfo.dart';
import 'package:qrbats_sp/pages/login_signup_pages/signup_page2.dart';
import '../../api_config/api_constants.dart';
import '../../components/buttons/round_button.dart';
import '../../components/text_field/text_field.dart';
import '../../components/texts/TextBlue.dart';
import '../../validations/SignUpInputValidations.dart';
import '../../widgets/snackbar/custom_snackbar.dart';
import '../getStart_page.dart';
import '../main_pages/main_page.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;


class Signup1 extends StatefulWidget {
  const Signup1({super.key});

  @override
  State<Signup1> createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {

  final _studentNameTextController = TextEditingController();
  final _indexNumberTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  void nextPage() {
    if(
    SignUpInputValidations.validateInputs(
      _studentNameTextController.text,
      _indexNumberTextController.text,
      _emailTextController.text,
      context
    )
    ){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return SignUp2(studentName: _studentNameTextController.text,email: _emailTextController.text,indexNumber: _indexNumberTextController.text,);
          }));
    }else{
    }
  }

  void previousPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return OpennigPage();
        }));
  }

  void loginPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return Login();
        }));
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Center(child: TextBlue(text: "SignUp", fontSize: 25)),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.white,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: screenHeight * 0.65,
                      width: screenWidth * 0.9,
                      decoration: _buildContainerDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            TextBlue(text: "Student Name", fontSize: 20),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: _studentNameTextController,
                              hintText: "student name",
                              width: screenWidth * 0.8,
                              obscureText: false,
                              icon: Icon(Icons.drive_file_rename_outline),
                            ),
                            SizedBox(height: 40),
                            TextBlue(text: "Index Number", fontSize: 20),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: _indexNumberTextController,
                              hintText: "index number",
                              width: screenWidth * 0.8,
                              obscureText: false,
                              icon: Icon(Icons.numbers),
                            ),
                            SizedBox(height: 40),
                            TextBlue(text: "Email Address", fontSize: 20),
                            SizedBox(height: 10),
                            MyTextField(
                              controller: _emailTextController,
                              hintText: "email",
                              width: screenWidth * 0.8,
                              obscureText: false,
                              icon: Icon(Icons.email),
                            ),
                            SizedBox(height: 40),


                          ],
                        ),
                      ),
                    ),
                  ),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              "If you already have an account? ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                            TextButton(onPressed: loginPage, child: Text("SignIn", style: TextStyle(color: Color(0xFF086494)),)),
                            Spacer(),
                          ],
                        ),
        
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            RoundButton(onTap: previousPage,icon: Icons.arrow_back,),
                            Spacer(),
                            ElevatedButton(onPressed: (){Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return MainPage();
                              }),
                            );}, child: Text("mainpage")),

                            RoundButton(
                              onTap: () {
                                CheckStudentInfo.checkStudentInfo(
                                  _emailTextController.text,
                                  _indexNumberTextController.text,
                                  nextPage,
                                  context,
                                );
                              },
                              icon: Icons.arrow_forward,
                            ),
                            SizedBox(width: 20,),
                          ],
                        ),
                        SizedBox(height: screenHeight*0.007,),
                      ],
                    ),
                  ),
                ),
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
