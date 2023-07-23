import 'package:chat_app_flutter_firebase/model/mesaage_model.dart';
import 'package:chat_app_flutter_firebase/utilities/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowMessagesPageVariables extends ChangeNotifier {
  List<Widget> chatList = [];
  List<Message> messageList = [];
  List<Widget> get getChatList => chatList;
  List messages = [];

  String colName = '';

  set setColName(String collectionName) {
    colName = collectionName;
    notifyListeners();
  }

  bool loaded = false;
  set changeLoadingState(bool changedState) {
    loaded = changedState;
    notifyListeners();
  }

  fetchMessages({required String me}
      // {required String collectionName}
      ) async {
    if (colName != '') {
      var tempo = FirebaseDatabase.instance.ref('chats').child(colName);
      tempo.onValue.listen((event) {
        messages = event.snapshot.value as List;
        debugPrint("\n here's the data messages: $messages\n\n");
        debugPrint("\n here's the collection Name : $colName\n\n");
        messageList.clear();
        debugPrint('cleared the message list : $messageList');
        for (var i = 0; i < messages.length; i++) {
          messageList
              .add(Message.fromJsonToMessageModel(jsonData: messages[i]));
        }
        chatList = messageList
            .map((e) => chatMesej(
                mesej: e.message, sendedByMe: e.sender == me, time: e.time))
            .toList();
        notifyListeners();
      });
    }
  }

  List? get getMessages => messages;
}
