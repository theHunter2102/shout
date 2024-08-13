import 'package:flutter/material.dart';

class AppNavigator
{
    static void navigateToScreen(BuildContext context, Widget screen) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
    }
}