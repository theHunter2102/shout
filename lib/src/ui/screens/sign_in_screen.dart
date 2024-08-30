import 'package:flutter/material.dart';
import 'package:shout/generated/l10n.dart';
import 'package:shout/src/ui/screens/details/main_screen.dart';
import 'package:shout/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:shout/src/ui/widgets/custom_dialog_widget.dart';
import 'package:shout/src/utils/validators.dart';

import '../../auth/user_auth/firebase_auth/firebase_auth_services.dart';
import '../../config/constants.dart';
import '../../my_app.dart';
import '../../navigation/app_navigator.dart';
import '../../services/news_api_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'forgot_password/forgot_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final NewsApiService _newsApiService = NewsApiService();
  final FirebaseAuthServices _firebaseAuthService = FirebaseAuthServices();
  bool _isLoading = false;

  Future<void> signIn() async{
    final email = _emailController.text;
    final password = _passwordController.text;

    final emailValidate = Validator.validateEmail(email);
    final passwordValidate = Validator.validatePassword(password);

    if(emailValidate != null || passwordValidate != null){
      showDialog(
          context: context,
          builder: (context) => CustomDialogWidget(
              content: emailValidate ?? passwordValidate ?? 'Invalid input',
              type: DialogType.error,
          )
      );
      return;
    }

    try{
      if(await _firebaseAuthService.signInWithEmailAndPassword(email, password) != null) {
        AppNavigator.navigateToScreen(context, const MainScreen());
      }
    }catch(e){
      print('Error caught: $e');
        showDialog(
            context: context,
            builder: (context)=> const CustomDialogWidget(
                content: 'Invalid email or password',
                type: DialogType.error,
            )
        );
    }
  }

  Future<void> signInWithGoogle() async{

   final user =  await _firebaseAuthService.signInWithGoogle();
   if(user != null){
     AppNavigator.navigateToScreen(context, const MainScreen());
   }else{
     showDialog(
         context: context,
         builder: (context)=>const CustomDialogWidget(
             content: 'Fail to sign with Google',
             type: DialogType.error
         )
     );
   }
  }
  Future<void> signInWithFaceBook() async{
    setState(() {
      _isLoading = true;
    });
    try{
      final user =  await _firebaseAuthService.signInWithFacebook();
      if(user != null){

        AppNavigator.navigateToScreen(context, const MainScreen());
      }else{
        showDialog(
            context: context,
            builder: (context)=>const CustomDialogWidget(
                content: 'Fail to sign with Face book',
                type: DialogType.error
            )
        );
      }
    }catch(e){
      print('Erorr sign in with face book $e');
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                      '${AppLocalizations.of(context)!.welcome}👋',
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
                child: Text(
                  AppLocalizations.of(context)!.signInSlogan,
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
                  hintText:  AppLocalizations.of(context)!.emailAddress,
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
                    hintText: AppLocalizations.of(context)!.password,
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
                        '${AppLocalizations.of(context)!.forgotPassword} ?',
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
                      signIn();
                    },
                    text: AppLocalizations.of(context)!.signIn,
                  )
              ),
              Positioned(
                top: screenHeight * 0.58,
                left: 20,
                right: 20,
                child: Text(
                  AppLocalizations.of(context)!.or,
                  style: const TextStyle(
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
                    borderColor: const Color(0xFFF3F4F6),
                    onPressed: (){
                      signInWithGoogle();
                    },
                    iconPath: 'assets/images/google1.svg',
                    color: Colors.white,
                    // icon: Icons.,
                    text: AppLocalizations.of(context)!.signInGG,
                      textStyle: const TextStyle(
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
                    borderColor: const Color(0xFFF3F4F6),
                    onPressed: (){
                      signInWithFaceBook();
                    },
                    iconPath: 'assets/images/facebook1.svg',
                    color: Colors.white,
                    text: AppLocalizations.of(context)!.signInFB,
                      textStyle: const TextStyle(
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
                      Padding(padding: EdgeInsets.only(left: 0),
                        child:  Text(
                          AppLocalizations.of(context)!.notHaveAccount,
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
                            AppNavigator.navigateToScreen(context, const SignUp());
                          },
                          style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signUp,
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
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),  // Chỉ báo tải dạng vòng tròn
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
