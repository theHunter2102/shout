import 'package:flutter/material.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';


class NewPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewPasswordState();
  }
}

class NewPasswordState extends State<NewPassword> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

  double? screenHeight = AppConstants.screenHeight;


  return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
      },
      home: Scaffold(
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
                        'Create New Password 🔒',
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
                  top: screenHeight * 0.13,
                  left: 20,
                  right: 0,
                  child: Text("You can create a new password, please\n"
                      "don't forget it too.",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textColor
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.22,
                  left: 20,
                  right: 20,
                  child: CustomTextField(
                    obscureText: true,
                    controller: _passwordController,
                    svgIconPath: 'assets/images/padlock.svg',
                    hintText: 'New Password',
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.31,
                  left: 20,
                  right: 20,
                    // width: screenWidth! * 0.8,
                    child: CustomTextField(
                      obscureText: true,
                      controller: _rePasswordController,
                      svgIconPath: 'assets/images/padlock.svg',
                      hintText: 'Repeat New Password',
                    ),
                ),

                Positioned(
                    top: screenHeight * 0.4,
                    left: 20,
                    right: 20,
                    child: CustomButton(
                      borderColor: Colors.transparent,
                      onPressed: (){
                        // go to Sign i
                        AppNavigator.navigateToScreen(context, SignIn());
                      },
                      text: 'Confirm',
                    )
                ),
                Positioned(
                    top: screenHeight * 0.91,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 0),
                          child:  Text(
                            'Did’t receive an email?',
                            style: TextStyle(
                                color: AppConstants.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 0),
                            child:  TextButton(
                              onPressed: (){},
                              style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft
                              ),
                              child: Text(
                                'Send again',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                ),
                              ),
                            )
                        ),
                      ],
                    )
                ),
              ],
            ),
          )
      )
  );
}
@override
void dispose() {
  _passwordController.dispose();
  _rePasswordController.dispose();
  super.dispose();
}
}
