import 'package:flutter/material.dart';

class SigninPageVariables extends ChangeNotifier {
  bool _signinPasswordVisible = false;
  bool _isPasswordValidationVisiblity = false;

  String errorString = "";

  bool _loading = false;

  get isLoading => _loading;

  set changeLoadingState(bool state) {
    _loading = state;
    notifyListeners();
  }

  get changePasswordValidationVisiblity {
    _isPasswordValidationVisiblity = true;
    notifyListeners();
  }

  set setErrorString(String mesej) {
    errorString = mesej;
    notifyListeners();
  }

  set updateEmailErrorString(bool isValid) {
    errorString = isValid ? "" : "Please enter a valid email Address";
    notifyListeners();
  }

  set updatePassErrorString(bool isValid) {
    errorString = isValid ? "" : "Please enter a valid password_";
    notifyListeners();
  }

  set updateFNameErrorString(bool isValid) {
    errorString = isValid ? "" : "Please enter the full name";
    notifyListeners();
  }

  bool get isSigninPassVisible => _signinPasswordVisible;
  bool get isPasswordValidationVisible => _isPasswordValidationVisiblity;

  set changeSigninPassVisibility(bool change) {
    _signinPasswordVisible = change;
    notifyListeners();
  }
}
