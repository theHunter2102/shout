import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/sign_in_screen.dart';
import '../../config/constants.dart';
import '../../navigation/app_navigator.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return WelcomeScreenState();
  }
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {

    double? screenHeight = AppConstants.screenHeight;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
          home: Scaffold(
            body: Container(
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
                      'assets/images/welcome.png',
                      width: 288,
                      height: 336,
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.70,
                    left: 0,
                    right: 0,
                    child: Text('All quiz in one place, be \n '
                        'the first to know the latest news',
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
                    // bottom: screenHeight * 0.07 ,
                    right: 20,
                    left: 20,
                    child: CustomButton(
                      borderColor: Colors.transparent,
                      text: 'Get Started',
                      onPressed: () {
                        AppNavigator.navigateToScreen(context, SignIn());
                      },
                    ),

                  ),
                ],
              ),
            ),
          ),
      debugShowCheckedModeBanner: false,
    );
  }
}
