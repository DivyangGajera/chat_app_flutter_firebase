import 'package:flutter/material.dart';

class ProfilePageVariables extends ChangeNotifier {
  bool _photoAvailable = false;

  get photoIsAvailable => _photoAvailable;

  set changePhotoAvailableState(bool change) {
    _photoAvailable = change;
    notifyListeners();
  }
}
