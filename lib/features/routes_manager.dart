import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/sign_in_page_constants.dart';
import '../constants/sign_up_page_constants.dart';
import '../view/sign_in.dart';
import '../view/sign_up.dart';

class RoutesManager {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sign_up':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignupPageVariables(),
            builder: (context, child) => SignUp(),
          ),
        );
      case '/sign_in':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SigninPageVariables(),
            builder: (context, child) => SignIn(),
          ),
        );
      default:
        return null;
    }
  }
}
