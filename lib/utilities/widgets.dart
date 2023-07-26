import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

SnackBar snackBar(
        {required String? mesej,
        required Color bgColor,
        bool showCloseButton = false}) =>
    SnackBar(
      content: Text(mesej!),
      showCloseIcon: showCloseButton,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: bgColor,
    );

class SignOutDialogue extends StatelessWidget {
  const SignOutDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: const Text(
        "Are you sure you want to Sign out ?",
        style: TextStyle(fontSize: 20),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              Hive.box(userLoginInfoSaveKey).clear();
              Navigator.pushReplacementNamed(context, '/sign_up');
            },
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                backgroundColor: Colors.white),
            child: const Text(
              "Yes",
              style: TextStyle(fontSize: 17, color: Colors.red),
            )),
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                backgroundColor: Colors.white),
            child: const Text(
              "No",
              style: TextStyle(fontSize: 17, color: Colors.green),
            )),
      ],
    );
  }
}

Widget chatMesej(
    {required String mesej, required bool sendedByMe, required String time}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:
          sendedByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              const BoxConstraints(minHeight: 40, minWidth: 80, maxWidth: 300),
          decoration: BoxDecoration(
            color: sendedByMe ? Colors.green : Colors.blueAccent,
            borderRadius: BorderRadiusDirectional.only(
                topStart: const Radius.circular(15),
                topEnd: const Radius.circular(15),
                bottomEnd: sendedByMe
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
                bottomStart: sendedByMe
                    ? const Radius.circular(15)
                    : const Radius.circular(0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              mesej,
              style: messageStyle,
            ),
          ),
        ),
      ],
    ),
  );
}

class ChatScreenNavigationDrawer extends StatelessWidget {
  const ChatScreenNavigationDrawer({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(children: [
      Container(
        alignment: Alignment.bottomLeft,
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/account_card.png'),
              fit: BoxFit.fitHeight),
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: drawerHeaderStyle,
          ),
        ),
      ),
      const Divider(),
      ListTile(
        onTap: () => Navigator.popAndPushNamed(context, '/profile',
            arguments: {'email': email, 'name': name}),
        trailing: const Icon(Icons.account_circle),
        title: const Text("Profile"),
      ),
      const Divider(),
      ListTile(
        onTap: () => Navigator.popAndPushNamed(context, '/themes'),
        trailing: const Icon(Icons.format_paint),
        title: const Text("Themes"),
      ),
      const Divider(),
      ListTile(
        onTap: () => Navigator.popAndPushNamed(context, '/licenses'),
        trailing: const Icon(Icons.receipt),
        title: const Text("Licenses"),
      ),
      const Divider(),
      ListTile(
        onTap: () => Navigator.popAndPushNamed(context, '/about_us'),
        trailing: const Icon(Icons.info),
        title: const Text("About Us"),
      ),
      const Divider(),
      ListTile(
        onTap: () {
          Navigator.pop(context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const SignOutDialogue(),
          );
        },
        trailing: const Icon(Icons.exit_to_app),
        title: const Text("Sign Out"),
      ),
      const Divider(),
    ]);
  }
}
