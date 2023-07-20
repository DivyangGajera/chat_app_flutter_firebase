// ignore_for_file: prefer_const_constructors

import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  // showLicensePage(
  //                     context: context,
  //                     applicationName: "My Chat App",
  //                     useRootNavigator: true,
  //                     applicationVersion: "1.0.0",
  //                     applicationIcon: Icon(Icons.chat));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(children: [
        Container(
          alignment: Alignment.bottomLeft,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/account_card.png'),
                fit: BoxFit.fitHeight),
            color: Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "My name Here",
              style: drawerHeaderStyle,
            ),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.popAndPushNamed(context, '/profile'),
          trailing: Icon(Icons.account_circle),
          title: Text("Profile"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.popAndPushNamed(context, '/themes'),
          trailing: Icon(Icons.format_paint),
          title: Text("Themes"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.popAndPushNamed(context, '/licenses'),
          trailing: Icon(Icons.receipt),
          title: Text("Licenses"),
        ),
        Divider(),
        ListTile(
          onTap: () => Navigator.popAndPushNamed(context, '/about_us'),
          trailing: Icon(Icons.info),
          title: Text("About Us"),
        ),
        Divider(),
        ListTile(
          onTap: () {},
          trailing: Icon(Icons.exit_to_app),
          title: Text("Sign Out"),
        ),
        Divider(),
      ]),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: () => Navigator.pushNamed(context, "/make_new_chat"),
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
                    arguments: {'user': "user $index"}),
                title: Text("user $index"),
                subtitle: Text("user$index@gmail.com"),
                leading: const Icon(Icons.account_circle_outlined),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 20),
      ),
    );
  }
}
