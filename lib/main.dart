import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shout/src/controller/main_screen_provider/profile_provider/language_provider.dart';
import 'package:shout/src/my_app.dart';

void main(List<String> args) async
{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(
    ChangeNotifierProvider(
        create: (context) => languageChange(),
      child: MyApp(),
    )

  );
}
// adb connect 192.168.1.3:5555