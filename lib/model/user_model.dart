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
  };
  return a;
}

class User {
  String name;
  String email;
  String password;
  String uid;
  List chat_persons;
  // String uid;

  User({
    required this.chat_persons,
    required this.email,
    required this.name,
    required this.password,
    required this.uid,
  });

  factory User.fromJsonToUserModel({required Map jsonData}) {
    List? a = jsonData['chat_persons'];

    return User(
      chat_persons: a ?? [],
      email: jsonData['email'] ?? "",
      name: jsonData['name'] ?? "",
      password: jsonData['password'] ?? "",
      uid: jsonData['uid'] ?? "",
    );
  }
}
