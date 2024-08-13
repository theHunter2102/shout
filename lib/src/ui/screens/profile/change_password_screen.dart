import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/constants.dart';
import '../../../my_app.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordScreenState();
  }
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reNewPasswordController = TextEditingController();
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
                          AppNavigator.navigateToScreen(context, MyApp());
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
                        "Change Password",
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
                // width: screenWidth! * 0.8,
                child: CustomTextField(
                  obscureText: true,
                  controller: _currentPassword,
                  svgIconPath: 'assets/images/padlock.svg',
                  hintText: 'Current Password',
                ),
              ),
              Positioned(
                top: screenHeight * 0.24,
                left: 20,
                right: 20,
                child: CustomTextField(
                  obscureText: true,
                  controller: _newPasswordController,
                  svgIconPath: 'assets/images/padlock.svg',
                  hintText: 'New Password',
                ),
              ),
              Positioned(
                top: screenHeight * 0.33,
                left: 20,
                right: 20,
                // width: screenWidth! * 0.8,
                child: CustomTextField(
                  obscureText: true,
                  controller: _reNewPasswordController,
                  svgIconPath: 'assets/images/padlock.svg',
                  hintText: 'Repeat New Password',
                ),
              ),
              Positioned(
                  top: screenHeight * 0.42,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    borderColor: Colors.transparent,
                    onPressed: (){
                      // go to Sign i
                      AppNavigator.navigateToScreen(context, SignIn());
                    },
                    text: 'Change Password',
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }

}
