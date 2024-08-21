import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/ui/screens/profile/profile_screen.dart';
import 'package:shout/src/ui/widgets/custom_language_widget.dart';

import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguageScreenState();
  }
}

class LanguageScreenState extends State<LanguageScreen> {


  Color _fieldColor = AppConstants.textFieldBg;
  Color _statusIconColor = AppConstants.textFieldBg;
  String _selectedLanguage = '';

  // void onClickLanguage(Color fieldColor, Color statusIconColor)
  // {
  //   _fieldColor = fieldColor;
  //   _statusIconColor = statusIconColor;
  // }

  void onClickLanguage(String language)
  {
    setState(() {
      _selectedLanguage = language;
    });
  }


  @override
  Widget build(BuildContext context) {
    double? screenHeight = AppConstants.screenHeight;
    double? screenWidth = AppConstants.screenWidth;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: screenHeight! * 0.08,
                  left: 20,
                  right: 20,
                child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 30,
                      child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // AppNavigator.navigateToScreen(context, MyApp());
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              // maximumSize: 20,
                              padding: EdgeInsets.zero
                            ),
                            child: SvgPicture.asset(
                              'assets/images/backLeftIcon.svg',
                              height: 12,
                              width: 12,
                            ),
                          ),
                    ),
                    Container(
                      width: screenWidth! * 0.8 - 10,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.language,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.15,
                left: 20,
                right: 20,
                child: CustomButtonLanguage(
                  text: AppLocalizations.of(context)!.english,
                  iconPath: 'assets/images/correctIcon.svg',
                  onPressed: () {
                    onClickLanguage('English');
                  },
                  borderColor: _selectedLanguage == 'English'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  color: _selectedLanguage == 'English'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  iconColor:_selectedLanguage == 'English'
                      ? Colors.white
                      : AppConstants.textFieldBg,
                  textColor: _selectedLanguage == 'English'
                      ? Colors.white
                      : AppConstants.textColor,
                ),
              ),
              Positioned(
                top: screenHeight * 0.24,
                left: 20,
                right: 20,
                child: CustomButtonLanguage(
                  text: AppLocalizations.of(context)!.turkish,
                  iconPath: 'assets/images/correctIcon.svg',
                  onPressed: () {
                    onClickLanguage('Turkish');
                  },
                  borderColor: _selectedLanguage == 'Turkish'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  color: _selectedLanguage == 'Turkish'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  iconColor:_selectedLanguage == 'Turkish'
                      ? Colors.white
                      : AppConstants.textFieldBg,
                  textColor: _selectedLanguage == 'Turkish'
                      ? Colors.white
                      : AppConstants.textColor,
                ),
              ),
              Positioned(
                top: screenHeight * 0.33,
                left: 20,
                right: 20,
                child: CustomButtonLanguage(
                  text: AppLocalizations.of(context)!.german,
                  iconPath: 'assets/images/correctIcon.svg',
                  onPressed: () {
                    onClickLanguage('German');
                  },
                  borderColor: _selectedLanguage == 'German'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  color: _selectedLanguage == 'German'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  iconColor:_selectedLanguage == 'German'
                      ? Colors.white
                      : AppConstants.textFieldBg,
                  textColor: _selectedLanguage == 'German'
                      ? Colors.white
                      : AppConstants.textColor,
                ),
              ),
              Positioned(
                top: screenHeight * 0.42,
                left: 20,
                right: 20,
                child: CustomButtonLanguage(
                  text: AppLocalizations.of(context)!.spanish,
                  iconPath: 'assets/images/correctIcon.svg',
                  onPressed: () {
                    onClickLanguage('Spanish');
                  },
                  borderColor: _selectedLanguage == 'Spanish'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  color: _selectedLanguage == 'Spanish'
                      ? AppConstants.purplePrimary
                      : AppConstants.textFieldBg,
                  iconColor:_selectedLanguage == 'Spanish'
                      ? Colors.white
                      : AppConstants.textFieldBg,
                  textColor: _selectedLanguage == 'Spanish'
                      ? Colors.white
                      : AppConstants.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
