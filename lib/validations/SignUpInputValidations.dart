import 'package:flutter/material.dart';
import '../widgets/snackbar/custom_snackbar.dart';

class SignUpInputValidations{

  static bool validateInputs(String studentName, String indexNo, String email,BuildContext context) {
    // Validate student name
    if (studentName.isEmpty) {
      CustomSnackBar.showSnackBar(context, 'Please enter student name.');
      return false;
    }

    // Validate index number
    RegExp indexNoRegex = RegExp(r'^EG/20\d{2}/\d{4}$');
    if (!indexNoRegex.hasMatch(indexNo)) {
      CustomSnackBar.showSnackBar(context, 'Please enter a valid index number (e.g., EG/20XX/XXXX).');
      return false;
    }

    // Validate email address
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      CustomSnackBar.showSnackBar(context, 'Please enter a valid email address.');
      return false;
    }

    return true; // All inputs are valid
  }
}