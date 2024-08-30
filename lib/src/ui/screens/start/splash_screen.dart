import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/constants.dart';
import 'onboarding_screen.dart';

class Splash extends StatefulWidget
{
    @override
    _SplashState createState()=> _SplashState();
}
class _SplashState extends State<Splash>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Onboarding()));
    });
  }


  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
      AppConstants.screenWidth = mediaQueryData.size.width;
      AppConstants.screenHeight = mediaQueryData.size.height;
      double? screenHeight = AppConstants.screenHeight;
      double? screenWidth = AppConstants.screenWidth;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          // alignment: Alignment.center,
          color: Color.fromARGB(255, 71, 90, 215),
          width: double.infinity,
          height: double.infinity,
          child:Stack(
            children: [
              Positioned(
                top: screenHeight! * 0.5,
                  left: screenWidth! * 0.3,
                  right: screenWidth * 0.3,
                  child: SvgPicture.asset(
                      'assets/images/shout.svg',
                    width: screenWidth * 0.4,
                    // height: 62,
                  )
              ),
              Positioned(
                  top: screenHeight * 0.46,
                  right: screenWidth * 0.23,
                  child: SvgPicture.asset(
                    'assets/images/subtract.svg',
                    width: 30,
                    height: 28,
                  )
              ) ,
              Positioned(
                  top: screenHeight * 0.55,
                  left: screenWidth * 0.25,
                  child: SvgPicture.asset(
                    'assets/images/subtract.svg',
                    width: 30,
                    height: 28,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}