import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../widgets/bookmark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BookmarkScreenState();
  }
}

class BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    double? screenHeight = AppConstants.screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 52, 0, 0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text(
                AppLocalizations.of(context)!.bookmarks,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: SizedBox(
              height: 40,
              child: Text(
                AppLocalizations.of(context)!.bookmarksSlogan,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppConstants.textColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: const BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: const BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: const BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              // color: Colors.black,
              child: BookmarkWidget(
                  image: 'assets/images/imgTestBg.png',
                  category: 'UI/UX Design',
                  title: 'A Simple Trick For Creating Color Palettes Quickly'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
