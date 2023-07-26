// ignore_for_file: use_build_context_synchronously

import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:chat_app_flutter_firebase/utilities/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FirebaseAuthHelper {
  static List users = [];
  static int count = 0;

  static signUp({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      // creating user in firebase auth
      UserCredential firebaseAuth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

      // getting old data back to add new into it
      var values = await firebaseDatabase.ref('users').get();
      List data = values.value as List<dynamic>;
      users = data.map((element) {
        return {
          'name': element['name'],
          'email': element['email'],
          'password': element['password'],
          'uid': element['uid'],
        };
      }).toList();
      // adding new data to the previous data
      users.add({
        'name': fullName,
        'email': email,
        'uid': firebaseAuth.user!.uid,
        'password': password
      });

      // upload new data to firebase realtime database
      await firebaseDatabase.ref("users").set(users);

      // save login info to local database hive
      Box localDB = Hive.box(userLoginInfoSaveKey);
      localDB.put('name', fullName);
      localDB.put('uid', firebaseAuth.user!.uid);
      localDB.put('email', email);
      localDB.put('password', password);
      localDB.put('userIndex', data.length + 1);

      //show signUp success message to user
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          mesej: "User Sign Up successful ...",
          bgColor: Colors.green,
          showCloseButton: true));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          mesej: e.message!, bgColor: Colors.red, showCloseButton: true));
    }
  }

  static Future<List> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // creating user in firebase auth
      UserCredential firebaseAuth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

      // getting old data back to add new into it
      var values = await firebaseDatabase.ref('users').get();
      List data = values.value as List<dynamic>;

      users = data.map((element) {
        return {
          'chatPersons': element['chatPersons'],
          'name': element['name'],
          'email': element['email'],
          'password': element['password'],
          'uid': element['uid'],
          'profile_pic': element['profile_pic'],
          'userIndex': element['userIndex']
        };
      }).toList();

      Box localDB = Hive.box(userLoginInfoSaveKey);

      // save login info to local database hive
      for (var element in users) {
        if (element['email'] == email) {
          localDB.put('name', element['name']);
          localDB.put('uid', firebaseAuth.user!.uid);
          localDB.put('email', email);
          localDB.put('password', password);
          localDB.put('profilePic', element['profilePic']);
          localDB.put('chatPersons', element['chatPersons']);
          localDB.put('userIndex', element['userIndex']);
          debugPrint('data stored');
        }
      }
      return [true, ''];
    } on FirebaseAuthException catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(snackBar(
      //     mesej: e.message!, bgColor: Colors.red, showCloseButton: true));
      return [false, e.message];
    }
  }
}
