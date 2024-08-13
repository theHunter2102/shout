import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CustomButtonProfile extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final String? iconPath;
  final Color borderColor;
  final Color iconColor;

  CustomButtonProfile({
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF4659D5),
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.iconPath,
    required this.borderColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 55),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: textStyle,
                textAlign: TextAlign.left,
              ),
            ),
            if (iconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: SvgPicture.asset(
                  iconPath!,
                  height: 24,
                  width: 24,
                  color: iconColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
