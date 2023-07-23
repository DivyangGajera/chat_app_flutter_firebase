// ignore_for_file: use_build_context_synchronously

import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:chat_app_flutter_firebase/model/user_model.dart' as user;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../controller/firebase_auth_helper.dart';
import '../controller/users_data_fetcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    process();
  }

  void process() async {
    Box getData = Hive.box(userLoginInfoSaveKey);
    List<user.User> ls = await UsersData.fetch();
    if (getData.get("email") != null) {
      List<String> data = [getData.get('email'), getData.get('password')];
      try {
        // await FirebaseAuth.instance
        //     .signInWithEmailAndPassword(email: data[0], password: data[1]);
        await FirebaseAuthHelper.signIn(
            context: context, email: data[0], password: data[1]);

        Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.popAndPushNamed(context, '/chats',
              arguments: {'userData': ls}),
        );
      } catch (temp) {
        Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.pushReplacementNamed(context, '/sign_up',
                arguments: {'userData': ls}));
      }
    } else {
      Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pushReplacementNamed(context, '/sign_up',
              arguments: {'userData': ls}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.chat,
              size: 200,
            ),
            CircularProgressIndicator(),
            Text(
              "loading...",
              style: TextStyle(fontSize: 30, color: Colors.black),
            )
          ],
        ),
      )),
    );
  }
}
