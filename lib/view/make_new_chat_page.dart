import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';

class MakeNewChat extends StatelessWidget {
  const MakeNewChat({super.key});

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
                    arguments: {'user': "New user $index"}),
                title: Text("New user $index"),
                subtitle: Text("newuser$index@gmail.com"),
                leading: Icon(Icons.account_circle_outlined),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: 20),
      ),
    );
  }
}
