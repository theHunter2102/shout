import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/sign_up/sign_up_screen.dart';

import '../../config/constants.dart';
import '../../my_app.dart';
import '../../navigation/app_navigator.dart';
import '../../services/news_api_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'forgot_password/forgot_screen.dart';
class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  NewsApiService _newsApiService = NewsApiService();

  @override
  Widget build(BuildContext context) {

    double? screenHeight = AppConstants.screenHeight;
    double? screenWidth = AppConstants.screenWidth;

    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
      debugShowCheckedModeBanner: false,
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
                      'Welcome Back 👋',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Transform.rotate(
                    //   angle: -0.2, // Góc xoay (radians), âm để lật ngược lại theo chiều ngược chiều kim đồng hồ
                    //   origin: Offset(0, 0), // Điểm xoay là gốc tọa độ của widget con
                    //   child: Transform(
                    //     alignment: Alignment.center,
                    //     transform: Matrix4.rotationY(3.14159), // Lật ngược lại theo trục Y (180 độ)
                    //     child: Icon(
                    //       Icons.waving_hand,
                    //       size: 28, // Kích thước của icon
                    //       color: Colors.yellow, // Màu sắc của icon
                    //     ),
                    //   ),
                    // )

                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.13,
                left: 20,
                right: 0,
                child: Text('I am happy to see you again. You can \n'
                    'continue where you left off by logging in',
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
                child: Container(
                  // width: screenWidth! * 0.8,
                  child: CustomTextField(
                    obscureText: true,
                    controller: _passwordController,
                    svgIconPath: 'assets/images/padlock.svg',
                    hintText: 'Password',
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.38,
                left: 20,
                right: 20,
                child:TextButton(
                    onPressed:(){
                      AppNavigator.navigateToScreen(context, ForgotPass());
                    },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerRight
                  ),
                    child: Text(
                        'Forgot password?',
                      style: TextStyle(
                        color: AppConstants.textColor,
                        fontSize: 16
                      ),
                    ),
                )
                ),
              Positioned(
                  top: screenHeight * 0.45,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    borderColor: Colors.transparent,
                    onPressed: (){
                      // _newsApiService.fetchNews('Random');
                      AppNavigator.navigateToScreen(context, MyApp());
                    },
                    text: 'Sign In',
                  )
              ),
              Positioned(
                top: screenHeight * 0.58,
                left: 20,
                right: 20,
                child: Text('or',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                  top: screenHeight * 0.67,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    borderColor: Color(0xFFF3F4F6),
                    onPressed: (){},
                    iconPath: 'assets/images/google1.svg',
                    color: Colors.white,
                    // icon: Icons.,
                    text: 'Sign In with Google',
                      textStyle: TextStyle(
                        color: AppConstants.textColor,
                        fontSize: 16
                      )
                  )
              ),
              Positioned(
                  top: screenHeight * 0.76,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    borderColor: Color(0xFFF3F4F6),
                    onPressed: (){},
                    iconPath: 'assets/images/facebook1.svg',
                    color: Colors.white,
                    text: 'Sign In with Facebook',
                      textStyle: TextStyle(
                          color: AppConstants.textColor,
                        fontSize: 16
                      ),
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
                          'Don''t have account?',
                          style: TextStyle(
                            color: Color(0xFF555A77),
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ), // Màu biểu tượng
                        ),
                      Padding(padding: const EdgeInsets.only(left: 0),
                        child:  TextButton(
                          onPressed: (){
                            AppNavigator.navigateToScreen(context, SignUp());
                          },
                          style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                        )// Màu biểu tượng
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
    _passwordController.dispose();
    super.dispose();
  }
}
