import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class CardHomeVertical extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final VoidCallback onBookmarkPress;
  final VoidCallback onTap;

  const CardHomeVertical({
    Key? key,
    required this.backgroundImage,
    required this.title,
    required this.onBookmarkPress,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? width = AppConstants.screenWidth! - 40;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width,
        margin: EdgeInsets.fromLTRB(1, 0, 0, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Color(0xFFC4C4C4),
              width: 0.2,
            ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
      
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: backgroundImage.isNotEmpty
                          ? NetworkImage(backgroundImage) as ImageProvider
                          : AssetImage('assets/images/imgDefaultNews.png') ,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Phần tiêu đề và bookmark chiếm 1/3
              Expanded(
                flex: 1,
                child: Container(
      
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Phần tiêu đề
                        SizedBox(
                          width: width * 0.7,
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                       IconButton(
                           onPressed: onBookmarkPress,
                           icon: SvgPicture.asset(

                             'assets/images/bookmark.svg',
                             width: 24,
                             height: 24,
                             color: AppConstants.textColor,
                           ),) // Phần bookmark

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
