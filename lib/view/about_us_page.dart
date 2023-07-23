import 'package:flutter/material.dart';

import '../utilities/titles.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(aboutUsPageTitle),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "My Chat App - About",
            style: drawerHeaderStyle,
          ),
          Text(
            "\nVersion 1.0.0",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(
            color: Colors.transparent,
          ),
          const Icon(
            Icons.chat_rounded,
            size: 80,
            color: Colors.blue,
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Text(
            "6th Aug 2023 - 9th Aug 2023\n\n My Chat App Inc.",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
