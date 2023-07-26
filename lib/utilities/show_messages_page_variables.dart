import 'package:chat_app_flutter_firebase/model/mesaage_model.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowMessagesPageVariables extends ChangeNotifier {
  List<Widget> chatList = [];
  List<Message> messageList = [];
  List<Widget> get getChatList => chatList;
  List messages = [];

  bool _loaded = false;
  bool _sendButtonVisible = false;
  bool get sendButtonVisibility => _sendButtonVisible;
  bool get isLoaded => _loaded;

  set setSendButtonVisibility(bool input) {
    _sendButtonVisible = input;
    notifyListeners();
  }

  String colName = '';

  set setColName(String collectionName) {
    colName = collectionName;
    notifyListeners();
  }

  set changeLoadingState(bool changedState) {
    _loaded = changedState;
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
            .map((e) => BubbleSpecialOne(
                  text: e.message,
                  color: e.sender == me ? Colors.grey : Colors.grey.shade300,
                  isSender: e.sender == me,
                  delivered: true,
                  seen: true,
                ))
            .toList();
        // chatList = messageList
        //     .map((e) => chatMesej(
        //         mesej: e.message, sendedByMe: e.sender == me, time: e.time))
        //     .toList();
        notifyListeners();
      });
    }
  }

  List? get getMessages => messages;
}
