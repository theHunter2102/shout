import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shout/src/ui/screens/sign_up/select_favotrite_screen.dart';
import 'package:shout/src/ui/widgets/custom_dialog_widget.dart';
import 'package:shout/src/utils/validators.dart';
import '../../../auth/user_auth/firebase_auth/firebase_auth_services.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SignUp extends StatefulWidget
{
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => SignUpState();
}


class SignUpState extends State<SignUp> {
  final FirebaseAuthServices _firebaseAuthService = FirebaseAuthServices();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();




  Future<void> _handleSignUp() async
  {
    final email = _emailController.text;
    final password = _passwordController.text;
    final  rePassword= _rePasswordController.text;
    final  username = _usernameController.text;

    final userValidate = Validator.validateUsername(username);
    final emailValidate = Validator.validateEmail(email);
    final passwordValidate= Validator.validatePassword(password);
    final rePasswordValidate= Validator.validateRePassword(password, rePassword);

    if(userValidate != null || emailValidate != null || passwordValidate != null || rePasswordValidate != null){
      showDialog(
        context: context,
        builder: (context) => CustomDialogWidget(
          content: userValidate ?? emailValidate ?? passwordValidate ?? rePasswordValidate ?? 'Invalid Input',
          type: DialogType.error,
        ),
      );
      return;
    }

    try{
      final user = await _firebaseAuthService.createAccount(email, password);
       if(user != null){
         final userId = user.uid;
         await FirebaseFirestore.instance.collection('users').doc(userId).set({
           'username' : username,
           'email' : email,
           'password' : password,
         });
         showDialog(
           context: context,
           builder: (context) => CustomDialogWidget(
             content: AppLocalizations.of(context)!.signUpSuccess,
             type: DialogType.success,
             textButtonSuccess: AppLocalizations.of(context)!.next,
             onSuccessPress: (){
               AppNavigator.navigateToScreen(context, FavoriteSelect());
             },
           ),
         );
      }
    }catch(e){
      if (e is Exception){
        showDialog(
          context: context,
          builder: (context) => CustomDialogWidget(
            content: AppLocalizations.of(context)!.emailExists,
            type: DialogType.error,
          ),
        );
      }else{
        print('Fail sign up : $e');
      }
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
                child: Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.welcomeTo} Shout 👋',
                      style: const TextStyle(
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
                  AppLocalizations.of(context)!.signUpSlogan,
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

                  hintText: AppLocalizations.of(context)!.emailAddress,
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
                  hintText:  AppLocalizations.of(context)!.password,
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
                  hintText:  AppLocalizations.of(context)!.rePass,
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
                    text:  AppLocalizations.of(context)!.signUp,
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
                          '${AppLocalizations.of(context)!.rePass}?',
                          style: const TextStyle(
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
                            child: Text(
                              AppLocalizations.of(context)!.signIn ,
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