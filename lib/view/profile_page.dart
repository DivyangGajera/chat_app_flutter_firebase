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

  int? userIndex;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    name = Hive.box(userLoginInfoSaveKey).get('name');
    imageLoader(varibales);
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    var userRef = FirebaseDatabase.instance.ref('users');
    userRef.keepSynced(true);
    var data = userRef.get();
    data.then((value) {
      List users = value.value as List;
      for (var i = 0; i < users.length; i++) {
        if (users[i]['name'] == name) {
          userIndex = i;
          print(userIndex);
        }
      }
    });
    var me = FirebaseDatabase.instance
        .ref('users/$userIndex')
        .get()
        .then((value) => print('userinfo ====> ${value.value}'));
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
                                    .ref('profilePic')
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
                                      element['profilePic'] = imageUrl;
                                    }
                                  },
                                );
                                await FirebaseDatabase.instance
                                    .ref('users')
                                    .set(users);
                                value.changePhotoAvailableState = true;
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.camera,
                                      size: 40,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
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
                                    .ref('profilePic')
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
                                      element['profilePic'] = imageUrl;
                                    }
                                  },
                                );
                                await FirebaseDatabase.instance
                                    .ref('users')
                                    .set(users);
                                value.changePhotoAvailableState = true;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.photo_library_sharp,
                                      size: 40,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                  position: badge.BadgePosition.custom(bottom: 10, end: 10),
                  showBadge: true,
                  badgeAnimation: const badge.BadgeAnimation.slide(),
                  badgeStyle: const badge.BadgeStyle(badgeColor: Colors.green),
                  badgeContent: const Icon(
                    Icons.camera,
                    size: 40,
                    color: Colors.white,
                  ),
                  child: value.photoIsAvailable
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          radius: 120,
                        )
                      : const Icon(
                          Icons.account_circle,
                          size: 250,
                        ),
                ),
                const SizedBox(
                  height: 70,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.account_box,
                    size: 40,
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          // isScrollControlled: true,
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Enter your name :",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  // decoration: InputDecoration(),
                                  autofocus: true,
                                  controller: nameController,
                                ),
                                ButtonBar(
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          var me = FirebaseDatabase.instance
                                              .ref('users/$userIndex');
                                          var dataSnapshot = me.get();
                                          dataSnapshot.then((value) {
                                            Map myData = value.value as Map;
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            backgroundColor: Colors.white),
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(
                                              fontSize: 17, color: Colors.red),
                                        )),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            backgroundColor: Colors.white),
                                        child: const Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.green),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => AlertDialog(
                        //       backgroundColor:
                        //           Theme.of(context).secondaryHeaderColor,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(25)),
                        //       title: const Text(
                        //         "Are you sure you want to Sign out ?",
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        //       actionsAlignment: MainAxisAlignment.spaceEvenly,
                        //       actions: [
                        //         OutlinedButton(
                        //             onPressed: () {
                        //               Navigator.pop(context);
                        //             },
                        //             style: OutlinedButton.styleFrom(
                        //                 side: const BorderSide(
                        //                     color: Colors.black),
                        //                 shape: RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(50)),
                        //                 backgroundColor: Colors.white),
                        //             child: const Text(
                        //               "Yes",
                        //               style: TextStyle(
                        //                   fontSize: 17, color: Colors.red),
                        //             )),
                        //         OutlinedButton(
                        //             onPressed: () {
                        //               Navigator.pop(context);
                        //             },
                        //             style: OutlinedButton.styleFrom(
                        //                 side: const BorderSide(
                        //                     color: Colors.black),
                        //                 shape: RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(50)),
                        //                 backgroundColor: Colors.white),
                        //             child: const Text(
                        //               "No",
                        //               style: TextStyle(
                        //                   fontSize: 17, color: Colors.green),
                        //             )),
                        //       ]),
                        // );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Name :'),
                      Text(widget.name,
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
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
                    Icons.info,
                    size: 40,
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              title: const Text(
                                "Enter the about description :",
                                style: TextStyle(fontSize: 20),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: [
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.black),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        backgroundColor: Colors.white),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.red),
                                    )),
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.black),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        backgroundColor: Colors.white),
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.green),
                                    )),
                              ]),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      )),
                  title: Text(
                    "About : ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(widget.email,
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.email,
                    size: 40,
                  ),
                  title: Text(
                    "E-mail : ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(widget.email,
                      style: Theme.of(context).textTheme.headlineSmall),
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
