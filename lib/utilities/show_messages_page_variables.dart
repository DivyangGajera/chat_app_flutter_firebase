import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowMessagesPageVariables extends ChangeNotifier {
  var messages;

  ShowMessagesPageVariables({required String collectionName}) {
    FirebaseDatabase.instance
        .ref('chats')
        .child(collectionName)
        .onValue
        .listen((event) {
      messages = event.snapshot.value;
      print("\n here's the data : $messages\n\n");
    });
  }

  List? get getMessages => messages;
}
