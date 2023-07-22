// ignore_for_file: prefer_const_constructors

import 'package:chat_app_flutter_firebase/model/user_model.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import '../utilities/widgtes.dart';

class Chats extends StatefulWidget {
  Chats({super.key, required this.ls});
  List<User> ls;

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<User> chat_persons = [];
  String name = '';
  String password = '';
  String email = '';
  String uid = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader();
  }

  loader() async {
    Box loginInfo = Hive.box(userLoginInfoSaveKey);
    name = loginInfo.get('name');
    password = loginInfo.get('password');
    email = loginInfo.get('email');
    uid = loginInfo.get('uid');

    widget.ls.forEach((element) {
      // print(element.name);
      if (element.email == email) {
        // print(element.chat_persons);
        for (var i = 0; i < element.chat_persons.length; i++) {
          // print("from chat persons : " + element.chat_persons[i]);
          // print("from db : " + widget.ls[i].name);
          widget.ls.forEach((element1) {
            if (element.chat_persons[i] == element1.name) {
              // print("object = ${element.chat_persons[i] == element1.name}");
              chat_persons.add(element1);
            }
          });
        }

        // widget.ls.remove(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ChatScreenNavigationDrawer(name: name, email: email),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: () {
          List<User> send = [];
          widget.ls.forEach((element) {
            if (element.email != email) {
              send.add(element);
            }
          });
          Navigator.pushNamed(context, "/make_new_chat",
              arguments: {'userData': send});
        },
        label: Text(chatsFABText),
        icon: const Icon(Icons.chat),
      ),
      appBar: AppBar(
        title: Text(chatsTitle),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.pushNamed(context, "/show_messages",
                    arguments: {'user': chat_persons[index].name}),
                title: Text(chat_persons[index].name),
                subtitle: Text(chat_persons[index].email),
                leading: const Icon(Icons.account_circle_outlined),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: chat_persons.length),
      ),
    );
  }
}
