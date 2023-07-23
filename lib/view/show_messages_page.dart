// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/controller/messages_controller.dart';
import 'package:chat_app_flutter_firebase/model/mesaage_model.dart';
import 'package:chat_app_flutter_firebase/utilities/show_messages_page_variables.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ShowMessages extends StatefulWidget {
  String user;
  bool newChat;

  ShowMessages({required this.user, super.key, this.newChat = false});

  @override
  State<ShowMessages> createState() => _ShowMessagesState();
}

class _ShowMessagesState extends State<ShowMessages> {
  // List<Widget> chatList = [
  //   chatMesej(mesej: "HI !!", sendedByMe: true),
  //   chatMesej(mesej: "Hello", sendedByMe: false),
  //   chatMesej(mesej: "How are you ?", sendedByMe: true),
  //   chatMesej(mesej: "I am fine, Thanks !", sendedByMe: false),
  //   chatMesej(
  //       mesej:
  //           "I currently have a listened operating on the whole of my screen. I would like to have a button in the bottom of the screen",
  //       sendedByMe: true),
  //   chatMesej(
  //       mesej:
  //           "ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction.",
  //       sendedByMe: false),
  // ];

  String sender = '';
  String colname = '';

  TextEditingController mesejText = TextEditingController();
  ShowMessagesPageVariables object = ShowMessagesPageVariables();

  @override
  void initState() {
    super.initState();
    Box userLoginInfoBox = Hive.box(userLoginInfoSaveKey);
    addNewChat(userLoginInfoBox);
    sender = userLoginInfoBox.get('name');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var temp = await FirebaseDatabase.instance
          .ref('chats')
          .child('$sender - ${widget.user}')
          .get();
      if (temp.exists) {
        object.setColName = '$sender - ${widget.user}';
        object.fetchMessages(me: sender);
        object.changeLoadingState = true;
      } else {
        object.setColName = '${widget.user} - $sender';
        object.fetchMessages(me: sender);
        object.changeLoadingState = true;
      }
      debugPrint('colName is ========> $colname');
    });
  }

  void addNewChat(Box userLoginInfoBox) async {
    if (widget.newChat) {
      DataSnapshot userDataSnapshot =
          await FirebaseDatabase.instance.ref('users').get();
      List userList = userDataSnapshot.value as List;
      // for (var i = 0; i < userList.length; i++) {
      //   if (userList[i]['email'] == userLoginInfoBox.get('email')) {
      //     List chatPersons = userList[i]['chat_persons'] as List;
      //     chatPersons.add(widget.user);
      //     await FirebaseDatabase.instance
      //         .ref('users')
      //         .child(i.toString())
      //         .update({'chat_persons': chatPersons});
      //   }
      // }
      for (var element in userList) {
        if (element['email'] == Hive.box(userLoginInfoSaveKey).get('email')) {
          userList.remove(element);
          List chatPersons = element['chat_persons'] as List;
          chatPersons.add(widget.user);
          element['chat_persons'] = chatPersons;
          userList.add(element);
          FirebaseDatabase.instance.ref('users').set(userList);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: object,
      child: Consumer<ShowMessagesPageVariables>(
        builder: (context, value, child) {
          if (value.loaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.user),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: value.chatList.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: value.chatList,
                            )
                          : const Center(
                              child: Text(
                                  "No Messages yet, send your 1st Message Now."),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.sizeOf(context).width - 50,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              onSubmitted: (input) {
                                input = "$input\n";
                              },
                              textInputAction: TextInputAction.newline,
                              controller: mesejText,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                  hintText: "Message : ",
                                  isDense: true),
                            )),
                        IconButton(
                            color: Colors.blue,
                            onPressed: () async {
                              var now = DateTime.now();
                              await MessagesController.sendMessage(
                                  mesej: Message(
                                      sender: sender,
                                      message: mesejText.text,
                                      receiver: widget.user,
                                      time: '${now.hour} : ${now.minute}'));
                              mesejText.clear();
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 30,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: SafeArea(
                  child: Center(
                child: CircularProgressIndicator(),
              )),
            );
          }
        },
      ),
    );
  }
}
