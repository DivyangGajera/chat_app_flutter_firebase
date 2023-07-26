// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/controller/messages_controller.dart';
import 'package:chat_app_flutter_firebase/model/mesaage_model.dart';
import 'package:chat_app_flutter_firebase/utilities/show_messages_page_variables.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
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
  String sender = '';
  String colname = '';

  TextEditingController mesejText = TextEditingController();
  ShowMessagesPageVariables object = ShowMessagesPageVariables();

  ScrollController scrollContoroller = ScrollController();

  @override
  void initState() {
    super.initState();
    Box userLoginInfoBox = Hive.box(userLoginInfoSaveKey);
    // addNewChat(userLoginInfoBox);
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
      if (scrollContoroller.hasClients) {
        scrollContoroller.jumpTo(scrollContoroller.position.maxScrollExtent);
      }
    });
  }

  // void addNewChat(Box userLoginInfoBox) async {
  //   if (widget.newChat) {
  //     DataSnapshot userDataSnapshot =
  //         await FirebaseDatabase.instance.ref('users').get();
  //     List userList = userDataSnapshot.value as List;

  //     for (var element in userList) {
  //       if (element['email'] == Hive.box(userLoginInfoSaveKey).get('email')) {
  //         userList.remove(element);
  //         List chatPersons = element['chat_persons'] as List;
  //         chatPersons.add(widget.user);
  //         element['chat_persons'] = chatPersons;
  //         userList.add(element);
  //         FirebaseDatabase.instance.ref('users').set(userList);
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user),
      ),
      body: ChangeNotifierProvider.value(
        value: object,
        child: Consumer<ShowMessagesPageVariables>(
          builder: (context, value, child) {
            if (value.isLoaded) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  scrollContoroller.animateTo(
                      scrollContoroller.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                },
              );
              return Container(
                decoration: BoxDecoration(
                    image: Theme.of(context).brightness == Brightness.dark
                        ? const DecorationImage(
                            image:
                                AssetImage('assets/images/chats_dark_bg.jpg'),
                            fit: BoxFit.fill)
                        : const DecorationImage(
                            image:
                                AssetImage('assets/images/chats_light_bg.jpg'),
                            fit: BoxFit.fill)),
                child: Column(
                  children: [
                    Expanded(
                      child: value.chatList.isNotEmpty
                          ? ListView.builder(
                              controller: scrollContoroller,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Message bubble = value.messageObjectList[index];
                                bool sentByMe = bubble.sender == sender;

                                return BubbleNormal(
                                  tail: true,
                                  color: sentByMe
                                      ? Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor!
                                      : Colors.green,
                                  isSender: sentByMe,
                                  text: bubble.message,
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                );
                              },
                              itemCount: value.messageObjectList.length,
                            )
                          : const Center(
                              child: Text(
                                "No Messages yet, send your 1st Message Now.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                onChanged: (input) {
                                  // input = "$input\n";
                                  if (input.trim().isNotEmpty) {
                                    value.setSendButtonVisibility = true;
                                  } else {
                                    value.setSendButtonVisibility = false;
                                  }
                                },
                                controller: mesejText,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                    ),
                                    hintText: "Message : ",
                                    isDense: true),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: value.sendButtonVisibility,
                            child: IconButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  if (mesejText.text.trim().isNotEmpty) {
                                    var now = DateTime.now();
                                    await MessagesController.sendMessage(
                                        mesej: Message(
                                            sender: sender,
                                            message: mesejText.text,
                                            receiver: widget.user,
                                            time:
                                                '${now.hour} : ${now.minute}'));
                                    mesejText.clear();
                                    value.setSendButtonVisibility = false;
                                  }
                                },
                                icon: const Icon(
                                  Icons.send,
                                  size: 30,
                                )),
                          )
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
      ),
    );
  }
}
