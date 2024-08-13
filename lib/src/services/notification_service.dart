import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shout/src/navigation/app_navigator.dart';

class NotificationService{

   void showNotificationDialog(BuildContext context, String title, String message,{ VoidCallback? onPress}){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: (){
                 if(onPress != null){
                     onPress();
                   }
                 Navigator.of(context).pop();
                },
                child: const Text('Ok')
            )
          ],
        );
      },

    );
  }

}