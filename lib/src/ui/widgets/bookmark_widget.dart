import 'package:flutter/material.dart';
import 'package:shout/src/config/constants.dart';
class BookmarkWidget extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final VoidCallback onTap;

  const BookmarkWidget(
      {Key? key,
        required this.image,
        required this.category,
        required this.title,
        required this.onTap

      }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        // padding: EdgeInsets.fromLTRB(0, 3, 3, 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          color: AppConstants.bookmarkBgIcon,
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // height: 150,
                // width: 150,
                // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            Expanded(
              flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: Text(
                              category,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7C82A1)
                            ),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: Text(
                              title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              color: Color(0xFF333647)
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
