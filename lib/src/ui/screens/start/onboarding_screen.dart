import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/start/welcome_screen.dart';

import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Onboarding extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return OnboardingState();
  }
}

class OnboardingState extends State<Onboarding>
{
  Color textColor = Color(0xFF7C82A1);

  // void navigateToWelcome(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  // }
  //
  @override
  Widget build(BuildContext context) {

    print('Current fontFamily: ${Theme.of(context).textTheme.bodyLarge?.fontFamily}');
    double? screenHeight = AppConstants.screenHeight;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
                child: Stack(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Positioned(
                      top: screenHeight! * 0.15,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/onboarding.png',
                        width: 288,
                        height: 336,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.63,
                      left: 0,
                      right: 0,
                      child: Text(
                        AppLocalizations.of(context)!.onboardTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.70,
                      left: 20,
                      right: 20,
                      child: Text(
                        AppLocalizations.of(context)!.onboardContent,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          color: AppConstants.textColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.85,
                      left: 20,
                      right: 20,
                      child: CustomButton(
                        borderColor: Colors.transparent,
                        text: AppLocalizations.of(context)!.next,
                        onPressed: () {
                          // navigateToWelcome(context);
                          AppNavigator.navigateToScreen(context, WelcomeScreen());
                        },
                      ),
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}
