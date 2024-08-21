import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/profile/privacy_screen.dart';
import 'package:shout/src/ui/screens/profile/terms_screen.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button_profile.dart';
import '../sign_in_screen.dart';
import 'change_password_screen.dart';
import 'language_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {

  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    double? screenHeight = AppConstants.screenHeight;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
            children: [
              Positioned(
                top: screenHeight! * 0.08,
                left: 20,
                right: 0,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.profile,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: screenHeight * 0.15,
                  left: 20,
                  right: 20,
                  child:  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Himejima', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('HimejimaGyoumei@gmail.com', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
              ),
              Positioned(
                top: screenHeight * 0.30,
                left: 20,
                right: 20,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  // color: AppConstants.textFieldBg,
                  decoration: BoxDecoration(
                    color: AppConstants.textFieldBg,
                    border: Border.all(
                      color: AppConstants.textFieldBg,
                      width: 1
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Stack(
                    children: [
                      // SizedBox(width: 20,),
                      Positioned(
                        top: 16,
                        left: 20,
                        child: Text(
                          AppLocalizations.of(context)!.notifications,
                          style: TextStyle(
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 18,
                        bottom: 0, 
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                              value: _notificationsEnabled,
                              onChanged: (bool value) {
                                setState(() {
                                  _notificationsEnabled = value;
                                });
                              },
                            inactiveTrackColor: AppConstants.textFieldBg,
                            // inactiveThumbColor: Colors.white,
                              activeColor:  Colors.white,
                              activeTrackColor:AppConstants.purplePrimary,
                            ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.4,
                left: 20,
                right: 20,
                child: CustomButtonProfile(
                  text: AppLocalizations.of(context)!.languageCountry,
                  iconPath: 'assets/images/angleRight.svg',
                  textStyle: TextStyle(
                      color: AppConstants.textColor
                  ),
                  onPressed: () {
                    AppNavigator.navigateToScreen(context, LanguageScreen());
                  },
                  color: AppConstants.textFieldBg,
                  borderColor: AppConstants.textFieldBg,
                  iconColor: Colors.transparent,
                ),
              ),
              Positioned(
                top: screenHeight * 0.5,
                left: 20,
                right: 20,
                child: CustomButtonProfile(
                  text: AppLocalizations.of(context)!.changePassword,
                  iconPath: 'assets/images/angleRight.svg',
                  textStyle: TextStyle(
                      color: AppConstants.textColor
                  ),
                  onPressed: () {
                    AppNavigator.navigateToScreen(context, ChangePasswordScreen());
                  },
                  color: AppConstants.textFieldBg,
                  borderColor: AppConstants.textFieldBg,
                  iconColor: Colors.transparent,
                ),
              ),
              Positioned(
                top: screenHeight * 0.61,
                left: 20,
                right: 20,
                child: CustomButtonProfile(
                  text: AppLocalizations.of(context)!.privacy,
                  iconPath: 'assets/images/angleRight.svg',
                  textStyle: TextStyle(
                      color: AppConstants.textColor
                  ),
                  onPressed: () {
                    AppNavigator.navigateToScreen(context, PrivacyScreen());
                  },
                  color: AppConstants.textFieldBg,
                  borderColor: AppConstants.textFieldBg,
                  iconColor: Colors.transparent,
                ),
              ),
              Positioned(
                top: screenHeight * 0.71,
                left: 20,
                right: 20,
                child: CustomButtonProfile(
                  text: AppLocalizations.of(context)!.terms,
                  iconPath: 'assets/images/angleRight.svg',
                  textStyle: TextStyle(
                      color: AppConstants.textColor
                  ),
                  onPressed: () {
                    AppNavigator.navigateToScreen(context, TermsScreen());
                  },
                  color: AppConstants.textFieldBg,
                  borderColor: AppConstants.textFieldBg,
                  iconColor: Colors.transparent,
                ),
              ),

              Positioned(
                top: screenHeight * 0.82,
                left: 20,
                right: 20,
                child: CustomButtonProfile(
                  text: AppLocalizations.of(context)!.signOut,
                  iconPath: 'assets/images/signOut.svg',
                  textStyle: TextStyle(
                      color: AppConstants.textColor
                  ),
                  onPressed: () {
                    AppNavigator.navigateToScreen(context, SignIn());
                  },
                  color: AppConstants.textFieldBg,
                  borderColor: AppConstants.textFieldBg,
                  iconColor: Colors.transparent,
                ),
              ),
              // Positioned(
              //
              // ),
            ]),
      ),
    );
  }
}
