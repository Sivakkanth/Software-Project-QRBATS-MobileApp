import 'package:flutter/material.dart';
import 'package:qrbats_sp/pages/login_signup_pages/login_page.dart';
import '../../components/buttons/round_button.dart';
import '../../components/text_field/text_field.dart';
import '../../components/texts/TextBlue.dart';
import '../../widgets/snackbar/custom_snackbar.dart';
import '../getStart_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void resetPassword() {
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Perform input validation
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      CustomSnackBar.showSnackBar(context, 'Please fill in all fields.');
      return;
    }

    if (newPassword != confirmPassword) {
      CustomSnackBar.showSnackBar(context, 'Passwords do not match.');
      return;
    }

    // If validation passes, perform password reset logic
    // You may call your backend API here to reset the password
    // Example:
    // resetPasswordApiCall(newPassword);

    // Show a snackbar to inform the user that the password has been reset
    CustomSnackBar.showSnackBar(context, 'Password reset successfully.');
  }

  void navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Login();
      }),
    );
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
                      text: "Reset Password",
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
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
                                text: "New Password",
                                fontSize: 20,
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: _newPasswordController,
                                hintText: "Enter new password",
                                width: screenWidth * 0.8,
                                obscureText: true,
                                icon: Icon(Icons.lock),
                              ),
                              SizedBox(height: 20),
                              TextBlue(
                                text: "Confirm Password",
                                fontSize: 20,
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: _confirmPasswordController,
                                hintText: "Confirm new password",
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
                            ElevatedButton(
                              onPressed: () => resetPassword(),
                              child: Text("Reset Password"),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.007),
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
