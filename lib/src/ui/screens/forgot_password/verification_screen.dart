import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shout/src/ui/screens/forgot_password/forgot_screen.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dialog_widget.dart';
import 'new_password_screen.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<StatefulWidget> createState() {
    return VerifyCodeState();
  }
}

class VerifyCodeState extends State<VerifyCode> {

  final emailAuth = EmailAuth(sessionName: 'shout otp');

  String _otpCode = "";


  Future<String?> getSaveOtp() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('otp');
  }

  Future<void> verifyOTP(String OTP) async{

      if(await getSaveOtp() == OTP){
        AppNavigator.navigateToScreen(context, NewPassword());
      }else{
        showDialog(
            context: context,
            builder: (context) =>  const CustomDialogWidget(
              content: 'OTP does not match',
              type: DialogType.error,
            )
        );
      }
  }
  void inputOtp(String otp)
  {
    setState(() {
      _otpCode = otp;
    });
  }


  final defaultPinTheme = PinTheme(
    width: 72,
    height: 72,
    textStyle: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color:AppConstants.textFieldBg,
      border: Border.all(color: Color.fromARGB(255, 243, 244, 246)),
      borderRadius: BorderRadius.circular(20),
    ),

  );

  final focusPinTheme = PinTheme(
    width: 72,
    height: 72,
    textStyle: TextStyle(
      fontSize: 16,
      color: AppConstants.purplePrimary,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: AppConstants.textFieldBg,
      border: Border.all(color: AppConstants.purplePrimary),
      borderRadius: BorderRadius.circular(20),
    ),
  );


  @override
  Widget build(BuildContext context) {
    double? screenHeight = AppConstants.screenHeight;
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
                child: Text(
                  'Verification Code ✅',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.13,
                left: 20,
                right: 0,
                child: Text(
                  'You need to enter 4-digit code we send to\nyour email address.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                top: screenHeight * 0.22,
                left: 20,
                right: 20,
                      child: Pinput(
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusPinTheme,
                      preFilledWidget: Text('-'),
                      onCompleted: (pin) => inputOtp(pin),
                    ),
              ),
              Positioned(
                top: screenHeight * 0.33,
                left: 20,
                right: 20,
                child: CustomButton(
                  borderColor: Colors.transparent,
                  onPressed: () {
                   verifyOTP(_otpCode);
                  },
                  text: 'Confirm',
                ),
              ),
              Positioned(
                top: screenHeight * 0.91,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        'Didn’t receive an email?',
                        style: TextStyle(
                          color: AppConstants.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: TextButton(
                        onPressed: () {
                          AppNavigator.navigateToScreen(context, ForgotPass());
                        },
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: const Text(
                          'Send again',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
