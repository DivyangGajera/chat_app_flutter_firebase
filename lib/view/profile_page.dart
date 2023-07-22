// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class ProfilePage extends StatelessWidget {
  ProfilePage({required this.name, required this.email, super.key});

  String name, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profilePageTitle),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 70,
          ),
          badge.Badge(
            onTap: () {},
            position: badge.BadgePosition.custom(bottom: 20, end: 25),
            showBadge: true,
            badgeAnimation: const badge.BadgeAnimation.slide(),
            badgeStyle: const badge.BadgeStyle(badgeColor: Colors.green),
            badgeContent: const Icon(
              Icons.camera,
              size: 40,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.account_circle,
              size: 250,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Row(
            children: [
              Text(
                "                  Name : ",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          ListTile(
            leading: const Icon(
              Icons.account_box,
              size: 40,
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                )),
            title: Text(
              name,
              style: drawerHeaderStyle,
            ),
            subtitle: const Text(
              "This is name will be visible to other person when you send the message.",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(indent: 60),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.email,
              size: 40,
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                )),
            title: Text(
              "E-mail : ",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: Text(
              email,
              style: drawerHeaderStyle,
            ),
          ),
        ]),
      ),
    );
  }
}
