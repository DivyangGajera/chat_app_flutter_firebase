import 'dart:io';

import 'package:chat_app_flutter_firebase/features/routes_manager.dart';
import 'package:chat_app_flutter_firebase/features/theme_manager.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  await Hive.openBox(userLoginInfoSaveKey);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeManager(),
        ),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: value.getCurrentThemeMode,
            onGenerateRoute: RoutesManager.onGeneratedRoute,
            initialRoute: "/splash_screen",
          );
        },
      ),
    );
  }
}
