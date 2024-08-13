import 'package:flutter/material.dart';
import '../../config/constants.dart';

class FavoriteTopicWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const FavoriteTopicWidget({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double? screenWidth = AppConstants.screenWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth! * 0.43 ,
        height: (screenWidth * 0.43 ) / 2.222222222222222,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.purplePrimary : color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppConstants.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
