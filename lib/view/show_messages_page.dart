// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/controller/messages_controller.dart';
import 'package:chat_app_flutter_firebase/model/mesaage_model.dart';
import 'package:chat_app_flutter_firebase/utilities/show_messages_page_variables.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:chat_app_flutter_firebase/utilities/widgtes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ShowMessages extends StatefulWidget {
  String user;

  ShowMessages({required this.user, super.key});

  @override
  State<ShowMessages> createState() => _ShowMessagesState();
}

class _ShowMessagesState extends State<ShowMessages> {
  List<Widget> chatList = [
    chatMesej(mesej: "HI !!", sendedByMe: true),
    chatMesej(mesej: "Hello", sendedByMe: false),
    chatMesej(mesej: "How are you ?", sendedByMe: true),
    chatMesej(mesej: "I am fine, Thanks !", sendedByMe: false),
    chatMesej(
        mesej:
            "I currently have a listened operating on the whole of my screen. I would like to have a button in the bottom of the screen",
        sendedByMe: true),
    chatMesej(
        mesej:
            "ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction.",
        sendedByMe: false),
    chatMesej(mesej: "HI !!", sendedByMe: true),
    chatMesej(mesej: "Hello", sendedByMe: false),
    chatMesej(mesej: "How are you ?", sendedByMe: true),
    chatMesej(mesej: "I am fine, Thanks !", sendedByMe: false),
    chatMesej(
        mesej:
            "I currently have a listened operating on the whole of my screen. I would like to have a button in the bottom of the screen",
        sendedByMe: true),
    chatMesej(
        mesej:
            "ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction.",
        sendedByMe: false),
  ];
  List? mesej = [];
  String sender = '';
  String colname = '';

  TextEditingController mesejText = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sender = Hive.box(userLoginInfoSaveKey).get('name');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var temp = await FirebaseDatabase.instance
          .ref('chats')
          .child('$sender - ${widget.user}')
          .get();
      if (temp.exists) {
        colname = '$sender - ${widget.user}';
      } else {
        colname = '${widget.user} - $sender';
      }
      print(colname);
    });
    // ChangeNotifierProvider(
    //   create: (context) => ShowMessagesPageVariables(collectionName: colname),
    //   builder: (context, child) => Consumer<ShowMessagesPageVariables>(
    //     builder: (context, value, child) {
    //       mesej = value.getMessages;
    //       return const SizedBox();
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (colname != '') {
      return ChangeNotifierProvider<ShowMessagesPageVariables>(
        create: (context) => ShowMessagesPageVariables(collectionName: colname),
        child: Consumer<ShowMessagesPageVariables>(
          builder: (context, value, child) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              mesej = value.getMessages;
            });
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.user),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: chatList,
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
          },
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
  }
}
