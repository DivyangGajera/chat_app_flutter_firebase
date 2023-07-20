import 'package:chat_app_flutter_firebase/features/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/titles.dart';

class ChangeThemePage extends StatelessWidget {
  const ChangeThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(changeThemeTitle),
      ),
      body: Consumer<ThemeManager>(
        builder: (context, value, child) {
          return GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 16 / 9,
            children: [
              GestureDetector(
                onTap: () {
                  value.setThemeMode = ThemeMode.light;
                  value.setThemeNo = 1;
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  // height: 50,
                  // width: 100,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/light_theme.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2,
                          color: value.getThemeNo == 1
                              ? Colors.blue
                              : Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Light Theme", style: changeThemeCardStyle),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  value.setThemeMode = ThemeMode.dark;
                  value.setThemeNo = 2;
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  // height: 50,
                  // width: 100,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/dark_theme.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2,
                          color: value.getThemeNo == 2
                              ? Colors.blue
                              : Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Dark Theme", style: changeThemeCardStyle),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  value.setThemeMode = ThemeMode.system;
                  value.setThemeNo = 3;
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  // height: 50,
                  // width: 100,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/system_theme.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2,
                          color: value.getThemeNo == 3
                              ? Colors.blue
                              : Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("System Default Theme",
                        style: changeThemeCardStyle),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
