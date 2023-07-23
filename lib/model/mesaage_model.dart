import 'dart:convert';

List<Message> fromJsonToMessageModelList({required String json}) =>
    jsonDecode(json)
        .map((element) => Message.fromJsonToMessageModel(jsonData: element))
        .toList();

List<Map> messageModelListToJsonList({required List<Message> ls}) =>
    ls.map((e) => messageModelToJson(message: e)).toList();

Map messageModelToJson({required Message message}) {
  Map a = {
    'sender': message.sender,
    'receiver': message.receiver,
    'message': message.message,
    'time': message.time,
    // 'order': message.order,
  };
  return a;
}

class Message {
  String sender;
  String receiver;
  String message;
  String time;
  // int order;

  Message({
    required this.sender,
    required this.message,
    required this.receiver,
    required this.time,
    // required this.order,
  });

  factory Message.fromJsonToMessageModel({required Map jsonData}) {
    return Message(
      sender: jsonData['sender'] ?? "",
      message: jsonData['message'] ?? "",
      receiver: jsonData['receiver'] ?? "",
      time: jsonData['time'] ?? "",
      // order: int.tryParse("${jsonData['order']}") ?? 0,
    );
  }
}
