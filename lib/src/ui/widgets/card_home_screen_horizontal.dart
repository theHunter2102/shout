import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class CardHomeHorizontal extends StatelessWidget {

  final String backgroundImage;
  final String title;
  final String category;
  final VoidCallback onBookmarkPress;
  final VoidCallback onTap;

  const CardHomeHorizontal(
      {
        Key? key,
        required this.backgroundImage,
        required this.title,
        required this.category,
        required this.onBookmarkPress,
        required this.onTap
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double? width = AppConstants.screenHeight! * 0.3152709359605911;


    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 256,
        height: 256,
        margin: EdgeInsets.fromLTRB(1, 0, 20, 0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage.isNotEmpty ?  NetworkImage(backgroundImage) as ImageProvider : AssetImage('assets/images/imgDefaultNews.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          color: Colors.black
        ),
        child: Stack(
          children: [
            // Container(
            //   width: width,
            //   height: width,
            //   decoration: ShapeDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment(0.00, -1.00),
            //       end: Alignment(0, 1),
            //       colors: [Color(0x0022242F), Color(0x7A22242F)],
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 24,
              // top: width*0.71875,
              top: 180,
              child: SizedBox(
                width: 200,
                child: Text(
                  title,
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
                      color: Colors.white,
                    ),
                  iconSize: 24,
                  onPressed: onBookmarkPress,
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
                category,
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