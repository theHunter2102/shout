import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shout/src/my_app.dart';
import 'package:shout/src/ui/screens/start/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'l10n/l10n.dart';

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
  runApp(MyApp()
    //   MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     supportedLocales:  L10n.all,
    //     locale: Locale('es'),
    //     localizationsDelegates: const [
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //       GlobalCupertinoLocalizations.delegate,
    //       AppLocalizations.delegate
    //     ],
    //     theme: ThemeData(
    //     ),
    //     home: SafeArea(
    //       child: Scaffold(
    //         body: Splash(),
    //       ),
    //     ),
    // )
  );
}
// adb connect 192.168.1.3:5555