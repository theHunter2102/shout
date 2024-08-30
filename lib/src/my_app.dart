import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/ui/screens/details/bookmark_screen.dart';
import 'package:shout/src/ui/screens/details/category_screen.dart';
import 'package:shout/src/ui/screens/details/home_screen.dart';
import 'package:shout/src/ui/screens/details/profile/profile_screen.dart';
import 'package:shout/src/ui/screens/start/splash_screen.dart';
import '../l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'config/constants.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales:  L10n.all,
      locale: Locale('en'),
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
