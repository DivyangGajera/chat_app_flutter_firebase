// ignore_for_file: use_build_context_synchronously

import 'package:chat_app_flutter_firebase/controller/firebase_auth_helper.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:chat_app_flutter_firebase/view/chats_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    process();
  }

  void process() async {
    Box getData = Hive.box(userLoginInfoSaveKey);
    if (getData.get("email") != null) {
      List<String> data = [getData.get('email'), getData.get('password')];
      try {
        print(data);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: data[0], password: data[1])
            .then((value) {
          print(value.user!.email == "divyanggajear214@gmail.com"
              ? 'done'
              : "not done");
        });
        // await FirebaseAuthHelper.signIn(
        //     context: context, email: data[0], password: data[1]);
        Future.delayed(Duration(seconds: 2));
        Navigator.popAndPushNamed(context, '/chats');
      } on FirebaseAuthException catch (e) {
        // TODO
        print(e.message);
        Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, '/sign_up');
      }
    } else {
      Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/sign_up');
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
            Icon(Icons.chat),
            CircularProgressIndicator(),
            Text(
              "laoding...",
              style: TextStyle(fontSize: 30, color: Colors.black),
            )
          ],
        ),
      )),
    );
  }
}
