import 'package:flutter/material.dart';
import 'package:qrbats_sp/api_services/CheckStudentInfo.dart';
import 'package:qrbats_sp/api_services/OTPService.dart';
import 'package:qrbats_sp/components/buttons/button_dark_small.dart';
import 'package:qrbats_sp/pages/login_signup_pages/signup_page2.dart';
import '../../components/buttons/round_button.dart';
import '../../components/text_field/text_field.dart';
import '../../components/texts/TextBlue.dart';
import '../../validations/SignUpInputValidations.dart';
import '../../widgets/snackbar/custom_snackbar.dart';
import '../getStart_page.dart';
import '../main_pages/main_page.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class OtpVerificationPage extends StatefulWidget {
  final String email;
  final String indexNumber;
  final String studentName;

  const OtpVerificationPage({
    Key? key,
    required this.email,
    required this.indexNumber,
    required this.studentName,
  }) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();



  void nextPage(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return SignUp2(studentName: widget.studentName,email: widget.email,indexNumber: widget.indexNumber,);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Center(child: TextBlue(text: "OTP Verification", fontSize: 25)),
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
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              TextBlue(text: "Enter the OTP sent to ${widget.email}", fontSize: 20),
                              SizedBox(height: 40),
                              MyTextField(
                                controller: _otpController,
                                hintText: "Enter OTP",
                                width: screenWidth * 0.8,
                                obscureText: false,
                                icon: Icon(Icons.lock_outline),
                              ),
                              SizedBox(height: 40),
                              MyButtonDS(
                                  onTap: (){
                                    OTPServoces.verifyOTP(
                                        context,
                                        widget.email,
                                        _otpController.text,
                                        nextPage
                                    );
                                  },
                                  text: "Verify OTP",
                                  width: 150),
                              SizedBox(height: 20,),
                              MyButtonDS(onTap:() {
                                  OTPServoces.generateOTP(context, widget.email);
                                }, text: "Resend OTP", width: 150),
                            ],
                          ),
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
                            SizedBox(width: 20,),
                            RoundButton(onTap: (){}, icon: Icons.arrow_back),
                            Spacer(),
                            MyButtonDS(onTap: nextPage, text: "Next Page", width: 150),
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
