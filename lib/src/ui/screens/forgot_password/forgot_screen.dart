import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/forgot_password/verification_screen.dart';

import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';
class ForgotPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPassState();
  }
}

class ForgotPassState extends State<ForgotPass>
{
  final TextEditingController  _emailController = TextEditingController();

  void navigateToVerify (BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Verify()));
  }


  @override
  Widget build(BuildContext context) {

      double? screenHeight = AppConstants.screenHeight;

      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Inter',
          ),
          debugShowCheckedModeBanner: false,
        home: Scaffold(
        body:  Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      top: screenHeight! * 0.08,
                      left: 20,
                      right: 0,
                      child:
                          Text(
                            'Forgot Password 🤔',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                    ),
                    Positioned(
                      top: screenHeight * 0.13,
                      left: 20,
                      right: 0,
                      child: Text('We need your email adress so we can send \n'
                          'you the password reset code.',
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
                        controller: _emailController,
                        svgIconPath: 'assets/images/email.svg',

                        hintText: 'Email address',
                      ),
                    ),

                    Positioned(
                        top: screenHeight * 0.31,
                        left: 20,
                        right: 20,
                        child: CustomButton(
                          borderColor: Colors.transparent,
                          onPressed: (){
                            navigateToVerify(context);
                          },
                          text: 'Next',
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
                                'Remember the password?',
                                style: TextStyle(
                                    color: AppConstants.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                              ), // Màu biểu tượng
                            ),
                            Padding(padding: const EdgeInsets.only(left: 0),
                                child:  TextButton(
                                  onPressed: (){
                                    AppNavigator.navigateToScreen(context, SignIn());
                                  },
                                  style: TextButton.styleFrom(
                                      alignment: Alignment.centerLeft
                                  ),
                                  child: Text(
                                    'Try again',
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
      _emailController.dispose();
      // _passwordController.dispose();
      super.dispose();
    }
}

