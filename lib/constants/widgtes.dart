import 'package:flutter/material.dart';

SnackBar snackBar(
        {required String? mesej,
        required Color bgColor,
        bool showCloseButton = false}) =>
    SnackBar(
      content: Text(mesej!),
      showCloseIcon: showCloseButton,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: bgColor,
    );
