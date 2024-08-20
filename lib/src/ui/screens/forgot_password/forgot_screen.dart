import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shout/src/auth/user_auth/firebase_auth/firebase_auth_services.dart';
import 'package:shout/src/ui/screens/forgot_password/verification_screen.dart';import 'package:shout/src/ui/widgets/custom_dialog_widget.dart';
import 'package:shout/src/utils/validators.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../sign_in_screen.dart';
import 'package:http/http.dart' as http;
class ForgotPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPassState();
  }
}

class ForgotPassState extends State<ForgotPass>
{
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  final TextEditingController  _emailController = TextEditingController();
  bool _isLoading = false;

  Future<bool> checkIfEmailExists(String email) async {
    try {
      var user = await _firebaseAuthServices.createAccount(email, 'dummyPassword');
      if(user!= null){
        _firebaseAuthServices.deleteAccount(user);
        return false;
      }
      return false;
    } catch (e) {
      if (e is Exception ) {
        String message = e.toString().replaceAll('Exception: ', '');
        if(message == 'email-already-in-use')
          // Email đã tồn tại, trả về tre
          print("Exception Check email $message");
          return true;
      }
      return false;
    }
  }

  String generateOTP(){
    final Random random = Random();
    final int otp = random.nextInt(8999)+1000;
    return  otp.toString();
}

  Future<void> navigateToVerify (BuildContext context) async {
    final  email = _emailController.text;
    final  emailValidate = Validator.validateEmail(email);


    if(emailValidate != null){
      showDialog(
          context: context,
          builder: (context) => CustomDialogWidget(
              content: emailValidate,
              type: DialogType.error,
          )
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try{
      if (await checkIfEmailExists(email)){
        String otp = generateOTP();
        bool otpSent = await sendOtpEmail(email, otp);
        if(otpSent){

          showDialog(
              context: context,
              builder: (context) =>  CustomDialogWidget(
                content: 'Check your email',
                type: DialogType.success,
                textButtonSuccess: 'Next',
                onSuccessPress: (){
                  AppNavigator.navigateToScreen(context, const VerifyCode());
                },
              )
          );
        }else{
          showDialog(
              context: context,
              builder: (context) =>  const CustomDialogWidget(
                content: 'Fail to send OTP',
                type: DialogType.error,
              )
          );
          print('Fail to send otp ');
        }
      }else{
        showDialog(
            context: context,
            builder: (context) =>  const CustomDialogWidget(
              content: 'The email is not registered',
              type: DialogType.error,
            )
        );
      }
    }catch(e){
      print('Exception Navigate -------------------- $e');
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> sendOtpEmail(String userEmail, String otp) async {
    String username = 'hiepvungoc211@gmail.com';
    String password = 'jbyu gcxh qowl eshb';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Shout')
      ..recipients.add(userEmail)
      ..subject = 'Your OTP Code'
      ..html = '''
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
          }
          .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 20px;
            text-align: center;
          }
          .otp-container {
            display: inline-block;
            background-color: #C3CCFFFF;
            border: 2px solid #475AD7FF;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 24px;
            font-weight: bold;
            color: #000000;
          }
          .otp-container span {
            margin: 0 8px;
            padding: 10px;
            border-bottom: 2px solid #4caf50;
          }
          .footer {
            text-align: center;
            padding: 20px;
            font-size: 14px;
            color: #888;
          }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="content">
                <img src="https://cdn-icons-png.flaticon.com/512/12178/12178734.png" alt="" style="width: 150px; height: 150px;"><br>
                <p style="padding-top: 10px; border-left: 4px solid #d0d0d0; font-family: 'Arial'; font-weight: bold; color: black">
              Here Is One Time OTP
            </p><p style="border-left: 4px solid #d0d0d0; font-family: 'Arial'; color: black ">
              (The code Effective in five minute) 
            </p><br>
                <p class="otp-container">$otp</p>
            </div>
            <div class="footer">
                <p>Best wishes, Shout</p>
            </div>
        </div>
    </body>
    ''';

    try {
      final sendReport = await send(message, smtpServer);
      saveOtp(userEmail,otp);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      print('Exception: $e');
      return false;
    }
  }

  Future<void> saveOtp(String email, String otp) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('otp', otp);
    await preferences.setString('email', email);
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
                            const Padding(padding: EdgeInsets.only(left: 0),
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
                                  child: const Text(
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
      // _passwordController.dispose();
      super.dispose();
    }
}

