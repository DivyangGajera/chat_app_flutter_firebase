// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<User> fromJsonToUserModelList({required String json}) => jsonDecode(json)
    .map((element) => User.fromJsonToUserModel(jsonData: element))
    .toList();

List<Map> userModelListToJsonList({required List<User> ls}) =>
    ls.map((e) => userModelToJson(message: e)).toList();

Map userModelToJson({required User message}) {
  Map a = {
    'email': message.email,
    'password': message.password,
    'name': message.name,
    'uid': message.uid,
    'chatPersons': message.chatPersons,
    'profilePic': message.profilePic,
    'userIndex': message.userIndex,
  };
  return a;
}

class User {
  String name;
  String email;
  String password;
  String uid;
  String profilePic;
  int userIndex;
  List chatPersons;
  // String uid;

  User({
    required this.profilePic,
    required this.userIndex,
    required this.chatPersons,
    required this.email,
    required this.name,
    required this.password,
    required this.uid,
  });

  factory User.fromJsonToUserModel({required Map jsonData}) {
    List? a = jsonData['chatPersons'];

    return User(
      userIndex: jsonData['userIndex'],
      profilePic: jsonData['profilePic'] ?? '',
      chatPersons: a ?? [],
      email: jsonData['email'] ?? "",
      name: jsonData['name'] ?? "",
      password: jsonData['password'] ?? "",
      uid: jsonData['uid'] ?? "",
    );
  }
}
