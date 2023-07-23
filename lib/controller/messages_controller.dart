import 'package:chat_app_flutter_firebase/model/mesaage_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessagesController {
  static DatabaseReference database = FirebaseDatabase.instance.ref('chats');

  static fetchMessages({
    required String sender,
    required String receiver,
  }) async {
    DataSnapshot dataSnapshot =
        await database.child('$sender - $receiver').get();
    List data = dataSnapshot.value as List;
    List<Message> messages =
        data.map((e) => Message.fromJsonToMessageModel(jsonData: e)).toList();
    return messages;
  }

  static sendMessage({
    required Message mesej,
  }) async {
    String collectionName = '';
    database.child('');
    DataSnapshot dataSnapshot =
        await database.child('${mesej.sender} - ${mesej.receiver}').get();
    debugPrint("sender - receiver exists ${dataSnapshot.exists}");
    if (dataSnapshot.exists) {
      collectionName = '${mesej.sender} - ${mesej.receiver}';
      List temp = dataSnapshot.value as List;
      List data = temp.map((element) => element).toList();
      data.add(messageModelToJson(message: mesej));
      await database.child('${mesej.sender} - ${mesej.receiver}').set(data);
    } else {
      collectionName = '${mesej.receiver} - ${mesej.sender}';
      dataSnapshot =
          await database.child('${mesej.receiver} - ${mesej.sender}').get();
      debugPrint("receiver - sender exists ${dataSnapshot.exists}");

      if (dataSnapshot.exists) {
        List temp = dataSnapshot.value as List;
        List data = temp.map((element) => element).toList();
        data.add(messageModelToJson(message: mesej));
        await database.child('${mesej.receiver} - ${mesej.sender}').set(data);
      } else {
        List data = [];
        data.add(messageModelToJson(message: mesej));
        await database.child('${mesej.receiver} - ${mesej.sender}').set(data);
      }
    }
    return collectionName;
  }
}
