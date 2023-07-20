import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:flutter/material.dart';

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

Widget chatMesej({required String mesej, required bool sendedByMe}) {
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
            child: Text(
              mesej,
              style: messageStyle,
            ),
          ),
        ),
      ],
    ),
  );
}
