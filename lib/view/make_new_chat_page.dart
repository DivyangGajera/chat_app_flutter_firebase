import 'package:chat_app_flutter_firebase/model/user_model.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';

class MakeNewChat extends StatelessWidget {
  final List<User> ls;
  const MakeNewChat({required this.ls, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(makeNewChatTitle),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.popAndPushNamed(
                    context, "/show_messages",
                    arguments: {'user': ls[index].name, 'newChat': true}),
                title: Text(
                  ls[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(ls[index].email),
                leading: const CircleAvatar(
                    radius: 28,
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                    )),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: ls.length),
      ),
    );
  }
}
