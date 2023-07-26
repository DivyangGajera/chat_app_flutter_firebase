import 'package:chat_app_flutter_firebase/utilities/profile_page_variables.dart';
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
        Map data = settings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignupPageVariables(),
            builder: (context, child) => SignUp(ls: data['userData']),
          ),
        );

      case '/sign_in':
        Map data = settings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SigninPageVariables(),
            builder: (context, child) => SignIn(ls: data['userData']),
          ),
        );

      case '/chats':
        Map data = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SigninPageVariables(),
            builder: (context, child) => Chats(ls: data['userData']),
          ),
        );

      case '/make_new_chat':
        Map data = settings.arguments as Map;

        
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => SigninPageVariables(),
          builder: (context, child) => MakeNewChat(ls: data['userData']),
        ),
      );

      case '/show_messages':
        Map arguments = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ShowMessages(
            user: arguments['user'],
            newChat: arguments['newChat'] ?? false,
          ),
        );

      case '/splash_screen':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case '/licenses':
        return MaterialPageRoute(
          builder: (context) => const LicensePage(
              applicationName: "My Chat App",
              applicationVersion: "1.0.0",
              applicationIcon: Icon(Icons.chat)),
        );

      case '/about_us':
        return MaterialPageRoute(
          builder: (context) => const AboutUsPage(),
        );

      case '/themes':
        return MaterialPageRoute(
          builder: (context) => const ChangeThemePage(),
        );

      case '/profile':
        Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<ProfilePageVariables>(
              create: (context) => ProfilePageVariables(),
              child: ProfilePage(email: args['email'], name: args['name'])),
        );
      default:
        return null;
    }
  }
}
