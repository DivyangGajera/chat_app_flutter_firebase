import 'package:chat_app_flutter_firebase/utilities/show_messages_page_variables.dart';
import 'package:chat_app_flutter_firebase/view/about_us_page.dart';
import 'package:chat_app_flutter_firebase/view/change_themes_page.dart';
import 'package:chat_app_flutter_firebase/view/chats_page.dart';
import 'package:chat_app_flutter_firebase/view/make_new_chat_page.dart';
import 'package:chat_app_flutter_firebase/view/profile_page.dart';
import 'package:chat_app_flutter_firebase/view/show_messages_page.dart';
import 'package:chat_app_flutter_firebase/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilities/sign_in_page_variables.dart';
import '../utilities/sign_up_page_variables.dart';
import '../view/sign_in_page.dart';
import '../view/sign_up_page.dart';

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

      case '/chats':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SigninPageVariables(),
            builder: (context, child) => const Chats(),
          ),
        );

      case '/make_new_chat':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SigninPageVariables(),
            builder: (context, child) => const MakeNewChat(),
          ),
        );

      case '/show_messages':
        Map arguments = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ShowMessagesPageVariables(),
            builder: (context, child) => ShowMessages(
              user: arguments['user'],
            ),
          ),
        );

      case '/splash_screen':
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case '/licenses':
        return MaterialPageRoute(
          builder: (context) => LicensePage(),
        );

      case '/about_us':
        return MaterialPageRoute(
          builder: (context) => AboutUsPage(),
        );

      case '/themes':
        return MaterialPageRoute(
          builder: (context) => ChangeThemePage(),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (context) => ProfilePage(),
        );
      default:
        return null;
    }
  }
}
