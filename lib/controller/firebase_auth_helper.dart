import 'package:chat_app_flutter_firebase/constants/widgtes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseAuthHelper {
  static List<Map> users = [];

  static signUp({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      UserCredential firebaseAuth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
      firebaseDatabase.ref('users').onValue.listen((event) {
        users = event.snapshot.value as List<Map>;
      });
      users.add({
        'name': fullName,
        'email': email,
        'uid': firebaseAuth.user!.uid,
        'password': password
      });
      firebaseDatabase.ref("users").set(users);
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          mesej: "User Sign Up successful ...",
          bgColor: Colors.green,
          showCloseButton: true));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          mesej: e.message!, bgColor: Colors.red, showCloseButton: true));
    }
  }
}
