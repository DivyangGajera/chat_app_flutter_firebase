// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/utilities/show_messages_page_variables.dart';
import 'package:chat_app_flutter_firebase/utilities/widgtes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowMessages extends StatelessWidget {
  String user;

  ShowMessages({required this.user, super.key});

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowMessagesPageVariables>(
      builder: (context, value, child) {
        return WillPopScope(
          onWillPop: () {
            if (value.isKeyboardOpen) {
              value.changeKeyboardState = false;
              Future.value(false);
            } else {
              return Future.value(true);
            }
            value.changeKeyboardState = false;
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(user),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height -
                      (value.isKeyboardOpen ? 150 + 307 : 146),
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
                            onSubmitted: (temp) {
                              value.changeKeyboardState = false;
                            },
                            onTap: () {
                              value.changeKeyboardState = true;
                            },
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            size: 30,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
