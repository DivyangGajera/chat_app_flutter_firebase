import 'package:flutter/material.dart';

class SignupPageVariables extends ChangeNotifier {
  bool _signupPasswordVisible = false;
  bool _isPasswordValidationVisiblity = false;

  String errorString = "";

  get changePasswordValidationVisiblity {
    _isPasswordValidationVisiblity = true;
    notifyListeners();
  }

  bool get isSignupPassVisible => _signupPasswordVisible;
  bool get isPasswordValidationVisible => _isPasswordValidationVisiblity;

  set updateEmailErrorString(bool isValid) {
    errorString = isValid ? "" : "Please enter a valid email Address";
    notifyListeners();
  }

  set updateFNameErrorString(bool isValid) {
    errorString = isValid ? "" : "Please enter the full name";
    notifyListeners();
  }

  set changeSignupPassVisibility(bool change) {
    _signupPasswordVisible = change;
    notifyListeners();
  }
}
