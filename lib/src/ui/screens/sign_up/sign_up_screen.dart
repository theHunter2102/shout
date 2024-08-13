import 'package:flutter/material.dart';
import 'package:shout/src/services/notification_service.dart';
import 'package:shout/src/ui/widgets/custom_dialog_widget.dart';
import '../../../auth/user_auth/firebase_auth/firebase_auth_services.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';
class SignUp extends StatefulWidget
{
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => SignUpState();
}


class SignUpState extends State<SignUp> {

  // final CustomDialogWidget _customDialogWidget = CustomDialogWidget();
  final FirebaseAuthServices _firebaseAuthService = FirebaseAuthServices();
  final NotificationService _notificationService = NotificationService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  Future<void> _handleSignUp() async
  {
    final email = _emailController.text;
    final password = _passwordController.text;
    try{
       if(await _firebaseAuthService.createAccount(email, password) != null){
         showDialog(
           context: context,
           builder: (context) => const CustomDialogWidget(
             content: 'Sign up successfully!',
             type: DialogType.success,
           ),
         );
      }else{
         showDialog(
             context: context,
             builder: (context) => const CustomDialogWidget(
               content: 'You have failed to sign up!',
               type: DialogType.error,
             ),
         );
       }

    }catch(e)
    {
      print('Fail sign up : $e');
    }
  }

  @override
  void dispose()
  {
    _usernameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double? screenHeight = AppConstants.screenHeight;

    return MaterialApp(
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
                child: const Row(
                  children: [
                    Text(
                      'Welcome to Shout 👋',
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
                child: const Text("Hello, I guess you are new around here. You \n"
                    "can start using the application after sign up.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
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
                  controller: _usernameController,
                  svgIconPath: 'assets/images/user.svg',
                  hintText: 'Username',
                ),
              ),
              Positioned(
                top: screenHeight * 0.31,
                left: 20,
                right: 20,
                child: CustomTextField(
                  controller: _emailController,
                  svgIconPath: 'assets/images/email.svg',

                  hintText: 'Email address',
                ),
              ),
              Positioned(
                top: screenHeight * 0.4,
                left: 20,
                right: 20,
                child: CustomTextField(
                  obscureText: true,
                  controller: _passwordController,
                  svgIconPath: 'assets/images/padlock.svg',
                  hintText: 'Password',
                ),
              ),
              Positioned(
                top: screenHeight * 0.49,
                left: 20,
                right: 20,
                // width: screenWidth! * 0.8,
                child: CustomTextField(
                  obscureText: true,
                  controller: _rePasswordController,
                  svgIconPath: 'assets/images/padlock.svg',
                  hintText: 'Repeat Password',
                ),
              ),
              Positioned(
                  top: screenHeight * 0.58,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    borderColor: Colors.transparent,
                    onPressed: (){
                      _handleSignUp();
                    },
                    text: 'Sign Up',
                  )
              ),
              Positioned(
                  top: screenHeight * 0.91,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 0),
                        child:  Text(
                          'Already have an account?',
                          style: TextStyle(
                              color: Color(0xFF555A77),
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 0),
                          child:  TextButton(
                            onPressed: (){
                              AppNavigator.navigateToScreen(context, SignIn());
                            },
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft
                            ),
                            child: const Text(
                              'Sign In',
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
        ),
      ),
    );
  }


}