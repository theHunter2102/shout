import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shout/src/navigation/app_navigator.dart';
import 'package:shout/src/ui/screens/sign_in_screen.dart';


enum DialogType { success, error }

class CustomDialogWidget extends StatefulWidget {
  // const CustomDialogWidget({super.key});
  final String content;
  final DialogType type;
  final String? textButtonSuccess;
  final VoidCallback? onSuccessPress;

  const CustomDialogWidget({
    super.key,
    required this.content,
    required this.type,
    this.textButtonSuccess,
    this.onSuccessPress,
  });

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {

  @override
  Widget build(BuildContext context) {
     String imgPath;
     String title;
     Color color;

     switch(widget.type){

       case DialogType.success:
         title = 'Success';
         imgPath = 'assets/images/successIcon.png';
         color = const Color(0xff44B984);
         break;
       case DialogType.error:
         title = 'Error';
         imgPath = 'assets/images/alertIcon.png';
         color = const Color(0xffEC5B5B);
         break;
     }

    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 32
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: color),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
               imgPath,
              // width: 200,
              // height: 200,
            ),
            const SizedBox(height: 5,),
            Text(
                title ,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 15,),
            Text(
                widget.content,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.black54,
                fontSize: 20
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32
                    ),
                    foregroundColor: color,
                    side: BorderSide(
                      color:  color
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                    child: Text('Back'),
                ),
                if(widget.type == DialogType.success && widget.onSuccessPress != null)
                  ElevatedButton(
                      onPressed: (){
                        widget.onSuccessPress!();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 32
                          ),
                          foregroundColor: color,
                          backgroundColor: color,
                          side: BorderSide(
                              color:  color
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                      child: Text(
                          widget.textButtonSuccess ?? '',
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      )
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
