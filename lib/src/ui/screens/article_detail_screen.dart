import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constants.dart';
import '../../my_app.dart';
import '../../navigation/app_navigator.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;


   ArticleDetailScreen({ required this.article});


  @override
  Widget build(BuildContext context) {

    final title = article['title'] is String ? article['title'] : 'No title';
    final image = article['image_url'] is String ? article['image_url'] : 'assets/images/imgDefaultNews.png';
    // final creator = article['creator'] is String ? article['creator'] : 'Unknown';
    // final content = article['content'] is String ? article['content'] : 'Content that does not exist';
    final content = article['description'] is String ? article['description'] : null;
    final creator = article['creator'] is List ? article['creator'].first : 'Unknown';

    return Scaffold(

      backgroundColor: Colors.white,
      body:ListView(
        padding: const EdgeInsets.all(20),
        children: [
              Container(
                margin: const EdgeInsets.only(top: 52),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: ElevatedButton(
                        onPressed: () {
                          AppNavigator.navigateToScreen(context, const MyApp());
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            // maximumSize: 20,
                            padding: EdgeInsets.zero
                        ),
                        child: SvgPicture.asset(
                          'assets/images/backLeftIcon.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              AppNavigator.navigateToScreen(context, const MyApp());
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                // maximumSize: 20,
                                padding: EdgeInsets.zero
                            ),
                            child: SvgPicture.asset(
                              'assets/images/share_icon.svg',
                              height: 18,
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              AppNavigator.navigateToScreen(context, const MyApp());
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                // maximumSize: 20,
                                padding: EdgeInsets.zero
                            ),
                            child: SvgPicture.asset(
                              'assets/images/bookmark.svg',
                              height: 20,
                              width: 14,
                              color: AppConstants.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 18),
                height: AppConstants.screenHeight! * 0.2364532019704433,
                decoration: BoxDecoration(
                  image: DecorationImage(
                     image: image.isNotEmpty ?  NetworkImage(image) as ImageProvider 
                         : const AssetImage('assets/images/imgDefaultNews.png'),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(12),
                  // color: Colors.blue
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 18),
                // height: 200,
                child: Text(
                    title,
                  // title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                // height: 100,
                // color: Colors.green,
                child: Text(
                  creator,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
          Container(
            margin: const EdgeInsets.only(top: 18),
            // color: Colors.green,
            child: Text(
              content == null ? 'Content that does not exist ' : content + content +"\n\n"+ content + "\n\n" + content,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      )
      // SingleChildScrollView(
      //   padding: EdgeInsets.all(20),
      //   child:
      // ),
    );
  }
}
