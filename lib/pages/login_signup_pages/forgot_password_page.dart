import 'package:flutter/material.dart';
import 'package:qrbats_sp/components/buttons/button_dark_large.dart';
import 'package:qrbats_sp/pages/login_signup_pages/login_page.dart';
import 'package:qrbats_sp/pages/login_signup_pages/reset_password_page.dart';
import '../../components/buttons/round_button.dart';
import '../../components/text_field/text_field.dart';
import '../../components/texts/TextBlue.dart';
import '../getStart_page.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  void resetPassword() {
    // Implement password reset logic here
    // For example, send a reset password link to the provided email
    String email = _emailController.text;
    // Example: Send reset password link to the provided email
    print('Reset password link sent to $email');
    // Show a snackbar to inform the user that the reset password link has been sent
    CustomSnackBar.showSnackBar(context, 'Reset password link sent to $email');

    Navigator.push(context, MaterialPageRoute(builder: (context){return ResetPasswordPage();}));
  }

  void navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Login();
      }),
    );
  }

  void sendOTP(){

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
                  child: Center(
                    child: TextBlue(
                      text: "Forgot Password",
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: screenHeight * 0.5,
                        width: screenWidth * 0.9,
                        decoration: _buildContainerDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              TextBlue(
                                text: "Email Address",
                                fontSize: 20,
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: _emailController,
                                hintText: "email",
                                width: screenWidth * 0.8,
                                obscureText: false,
                                icon: Icon(Icons.email),
                              ),
                              SizedBox(height: 20),
                              MyButtonDS(onTap: sendOTP, text: "Send OTP", width: 200),
                              SizedBox(height: 30),
                              TextBlue(
                                text: "Enter The OTP",
                                fontSize: 20,
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: _emailController,
                                hintText: "enter OTP",
                                width: screenWidth * 0.8,
                                obscureText: false,
                                icon: Icon(Icons.lock_outline),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            RoundButton(
                              onTap: () => navigateToLoginPage(),
                              icon: Icons.arrow_back,
                            ),
                            Spacer(),
                            MyButtonDS(onTap: resetPassword, text: "Reset Password", width: 200),

                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.05),
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
