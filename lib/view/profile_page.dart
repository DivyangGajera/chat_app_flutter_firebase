// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:chat_app_flutter_firebase/utilities/profile_page_variables.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.name, required this.email, super.key});

  String name, email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imageUrl = '', name = '';
  ProfilePageVariables varibales = ProfilePageVariables();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    name = Hive.box(userLoginInfoSaveKey).get('name');
    imageLoader(varibales);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profilePageTitle),
      ),
      body: Center(
        child: ChangeNotifierProvider.value(
          value: varibales,
          child: Consumer<ProfilePageVariables>(
            builder: (context, value, child) {
              return Column(children: [
                const SizedBox(
                  height: 70,
                ),
                badge.Badge(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) => ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                XFile? image = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                var ref = FirebaseStorage.instance
                                    .ref('profile_pic')
                                    .child(name);
                                ref.putFile(File(image!.path));
                                imageUrl = await ref.getDownloadURL();
                                DataSnapshot dataSnap = await FirebaseDatabase
                                    .instance
                                    .ref('users')
                                    .get();
                                List users = dataSnap.value as List;
                                users.forEach(
                                  (element) {
                                    if (element['name'] == name) {
                                      element['profile_pic'] = imageUrl;
                                    }
                                  },
                                );
                                await FirebaseDatabase.instance
                                    .ref('users')
                                    .set(users);
                                value.changePhotoAvailableState = true;
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.camera,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          OutlinedButton(
                              onPressed: () async {
                                XFile? image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                var ref = FirebaseStorage.instance
                                    .ref('profile_pic')
                                    .child(name);
                                ref.putFile(File(image!.path));
                                imageUrl = await ref.getDownloadURL();
                                DataSnapshot dataSnap = await FirebaseDatabase
                                    .instance
                                    .ref('users')
                                    .get();
                                List users = dataSnap.value as List;
                                users.forEach(
                                  (element) {
                                    if (element['name'] == name) {
                                      element['profile_pic'] = imageUrl;
                                    }
                                  },
                                );
                                await FirebaseDatabase.instance
                                    .ref('users')
                                    .set(users);
                                value.changePhotoAvailableState = true;
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.photo_library_sharp,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                  position: badge.BadgePosition.custom(bottom: 20, end: 25),
                  showBadge: true,
                  badgeAnimation: const badge.BadgeAnimation.slide(),
                  badgeStyle: const badge.BadgeStyle(badgeColor: Colors.green),
                  badgeContent: value.photoIsAvailable
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          radius: 150,
                        )
                      : const Icon(
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
                      style: Theme.of(context).textTheme.titleMedium,
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
                    widget.name,
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    widget.email,
                    style: drawerHeaderStyle,
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }

  Future<void> imageLoader(ProfilePageVariables varibales) async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref('users').get();
    List users = dataSnapshot.value as List;
    users.forEach((element) {
      print(element);
      if (element['name'] == name) {
        print("element");
        if (element['profile_pic'] != null && element['profile_pic'] != '') {
          print(element['profile_pic']);
          imageUrl = element['profile_pic'];
          varibales.changePhotoAvailableState = true;
        }
      }
    });
  }
}
