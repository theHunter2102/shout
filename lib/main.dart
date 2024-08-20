import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/splash_screen.dart';

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
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: Scaffold(
          body: Splash(),
        ),
    )
  );
}
// adb connect 192.168.1.3:5555