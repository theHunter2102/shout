import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/ui/screens/profile/profile_screen.dart';

import '../../../config/constants.dart';
import '../../../my_app.dart';
import '../../../navigation/app_navigator.dart';


class PrivacyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PrivacyScreenState();
  }
}

class PrivacyScreenState extends State<PrivacyScreen> {

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
                      width: 40,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          AppNavigator.navigateToScreen(context, ProfileScreen());
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            // maximumSize: 20,
                            padding: EdgeInsets.zero
                        ),
                        child: SvgPicture.asset(
                          'assets/images/backLeftIcon.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth! * 0.8 - 50,
                      alignment: Alignment.center,
                      child: Text(
                        "Privacy",
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
                top: screenHeight * 0.5,
                left: 20,
                right: 20,
                child: Center(
                  child: Text(
                    "COMING SOON ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
