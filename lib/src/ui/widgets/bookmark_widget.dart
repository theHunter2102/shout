import 'package:flutter/material.dart';

class BookmarkWidget extends StatelessWidget {
  final String image;
  final String category;
  final String title;

  const BookmarkWidget(
      {Key? key,
        required this.image,
        required this.category,
        required this.title

      }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        // padding: EdgeInsets.fromLTRB(0, 3, 3, 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            Expanded(
              flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
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
