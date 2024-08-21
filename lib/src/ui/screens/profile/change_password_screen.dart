import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/ui/screens/profile/profile_screen.dart';
import '../../../auth/user_auth/firebase_auth/firebase_auth_services.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dialog_widget.dart';
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
  final FirebaseAuthServices  _firebaseAuth = FirebaseAuthServices();

  Future<void> changePassword() async{
    final currentPassword = _currentPassword.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _reNewPasswordController.text;

    final currentPasswordValidate = Validator.validatePassword(currentPassword);
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

    bool checkCurrentPass = await _firebaseAuth.reAuthUser(currentPassword);

    try{
      if(checkCurrentPass){
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
      }else{
        showDialog(
            context: context,
            builder: (context)=> const CustomDialogWidget(
                content: 'The current password is incorrect',
                type: DialogType.error
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
                     changePassword();
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
