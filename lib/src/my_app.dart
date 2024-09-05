import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shout/src/controller/main_screen_provider/profile_provider/language_provider.dart';
import 'package:shout/src/ui/screens/start/splash_screen.dart';
import '../l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class MyApp extends StatelessWidget {

  String locale = languageChange().language;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales:  L10n.all,
      locale: Locale(locale),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      home: Splash(),
    );
  }


}
