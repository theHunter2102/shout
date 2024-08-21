import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/ui/screens/profile/profile_screen.dart';

import '../../../config/constants.dart';
import '../../../my_app.dart';
import '../../../navigation/app_navigator.dart';

class TermsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TermsScreenState();
  }
}

class TermsScreenState extends State<TermsScreen> {


  Color _fieldColor = AppConstants.textFieldBg;
  Color _statusIconColor = AppConstants.textFieldBg;
  String _selectedLanguage = '';

  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reNewPasswordController = TextEditingController();
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
                          AppNavigator.navigateToScreen(context, ProfileScreen());                        },
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
                        "Terms & Conditions",
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
                left: 40,
                right: 20,
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur \n"
                        "adipiscing elit, sed do eiusmod tempor \n"
                        "incididunt ut labore et dolore magna aliqua.\n"
                        " Ut enim ad minim veniam, quis nostrud \n"
                        "exercitation ullamco laboris nisi ut aliquip ex\n "
                        "ea commodo consequat. Duis aute irure \n"
                        "dolor in reprehenderit in voluptate velit esse \n"
                        "cillum dolore eu fugiat nulla pariatur.\n"
                        " Excepteur sint occaecat cupidatat non\n"
                        "proident, sunt in culpa qui officia deserunt \n"
                        "mollit anim id est laborum. \n"
                        "\n"
                        "Sed ut perspiciatis unde omnis iste natus\n"
                        "error sit voluptatem accusantium\n"
                        " doloremque laudantium, totam rem aperiam,\n"
                        " eaque ipsa quae ab illo inventore veritatis et\n"
                        " quasi architecto beatae vitae dicta sunt\n"
                        " explicabo.\n"
                        "\n"
                        "Nemo enim ipsam voluptatem quia voluptas \n"
                        "sit aspernatur aut odit aut fugit, sed quia \n"
                        "consequuntur magni dolores eos qui ratione \n"
                        "voluptatem sequi nesciunt.\n"
                        "\n"
                        "Neque porro quisquam est, qui dolorem \n"
                        "ipsum quia dolor sit amet, consectetur, \n"
                        "adipisci velit, sed quia non numquam eius \n"
                        "modi tempora incidunt ut labore et dolore \n"
                        "magnam aliquam quaerat voluptatem. \n",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
