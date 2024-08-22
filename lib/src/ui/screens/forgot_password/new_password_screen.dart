import 'package:flutter/material.dart';
import 'package:shout/src/ui/widgets/custom_dialog_widget.dart';
import 'package:shout/src/utils/validators.dart';
import '../../../auth/user_auth/firebase_auth/firebase_auth_services.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class NewPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewPasswordState();
  }
}

class NewPasswordState extends State<NewPassword> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final FirebaseAuthServices  _firebaseAuth = FirebaseAuthServices();

  Future<void> updatePassword() async{
    final newPassword = _passwordController.text;
    final confirmPassword = _rePasswordController.text;
    final newPasswordValidate = Validator.validatePassword(newPassword);
    final confirmPasswordValidate = Validator.validateRePassword(newPassword, confirmPassword);

    if(newPasswordValidate != null || confirmPasswordValidate != null){
      showDialog(
        context: context,
        builder: (context) => CustomDialogWidget(
          content: newPasswordValidate ?? confirmPasswordValidate ?? 'Invalid Input',
          type: DialogType.error,
        ),
      );
      return;
    }

    try{
      if(await _firebaseAuth.updatePasswordForgot(newPassword)){
        showDialog(
            context: context,
            builder: (context) => CustomDialogWidget(
                content: 'Update password completed',
                type: DialogType.success,
              textButtonSuccess: 'Sign in',
              onSuccessPress: (){
                  AppNavigator.navigateToScreen(context, SignIn());
              },
            )
        );
      }
    }catch(e)
    {
      print('Exception UpdatePassword: $e');
    }

  }


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
                        '${AppLocalizations.of(context)!.createNewPass} 🔒',
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
                    AppLocalizations.of(context)!.createNewPassSlogan,
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
                    hintText: AppLocalizations.of(context)!.newPass,
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
                      hintText: AppLocalizations.of(context)!.reNewPass,
                    ),
                ),

                Positioned(
                    top: screenHeight * 0.4,
                    left: 20,
                    right: 20,
                    child: CustomButton(
                      borderColor: Colors.transparent,
                      onPressed: (){
                        updatePassword();
                      },
                      text: AppLocalizations.of(context)!.confirm,
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
                            '${AppLocalizations.of(context)!.rememberCurrentPass}',
                            style: TextStyle(
                                color: AppConstants.textColor,
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
                                AppLocalizations.of(context)!.tryAgain,
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
