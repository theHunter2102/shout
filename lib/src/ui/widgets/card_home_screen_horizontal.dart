import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class CardHomeHorizontal extends StatefulWidget {

  final String backgroundImage;
  final String title;
  final String category;
  final VoidCallback onBookmarkPress;
  final VoidCallback onTap;
  Color? colorBookmarkIcon;


  CardHomeHorizontal(
       {
         super.key,
        required this.colorBookmarkIcon,
        required this.backgroundImage,
        required this.title,
        required this.category,
        required this.onBookmarkPress,
        required this.onTap
      });

  @override
  State<StatefulWidget> createState() => CardHomeHorizontalState();
}


class CardHomeHorizontalState extends State<CardHomeHorizontal> {



  @override
  Widget build(BuildContext context) {

    double? width = AppConstants.screenHeight! * 0.3152709359605911;


    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 256,
        height: 256,
        margin: const EdgeInsets.fromLTRB(1, 0, 20, 0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.backgroundImage.isNotEmpty ?  NetworkImage(widget.backgroundImage) as ImageProvider : AssetImage('assets/images/imgDefaultNews.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          color: Colors.black
        ),
        child: Stack(
          children: [
            Positioned(
              left: 24,
              // top: width*0.71875,
              top: 180,
              child: SizedBox(
                width: 200,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top:20,
                child: IconButton(
                  icon: SvgPicture.asset(
                      'assets/images/bookmark.svg',
                      color: widget.colorBookmarkIcon,
                    ),
                  iconSize: 24,
                  onPressed: widget.onBookmarkPress,
                ) ,
                // SvgPicture.asset(
                //   'assets/images/bookmark.svg',
                //   color: Colors.white,
                // ),
              ),
            // ),
            Positioned(
              left: 24,
              // top: width * 0.64453125,
              top: 160,
              child: Text(
                widget.category,
                style: TextStyle(
                  color: Color(0xFFF3F3F6),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  height: 0.11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}