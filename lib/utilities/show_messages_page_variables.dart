import 'package:flutter/material.dart';

class ShowMessagesPageVariables extends ChangeNotifier {
  bool _keyboardOpen = false;

  bool get isKeyboardOpen => _keyboardOpen;

  set changeKeyboardState(bool state) {
    _keyboardOpen = state;
    print("\n\nNow Keyboard state is : ${_keyboardOpen}\n\n");
    notifyListeners();
  }
}
