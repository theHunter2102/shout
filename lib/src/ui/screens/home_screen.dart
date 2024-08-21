import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constants.dart';
import '../../navigation/app_navigator.dart';
import '../../services/news_api_service.dart';
import '../widgets/card_home_screen_horizontal.dart';
import '../widgets/card_home_screen_vertical.dart';
import '../widgets/custom_text_field.dart';
import 'article_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final Color _fieldColor = AppConstants.textFieldBg;
  final Color _statusTextColor = AppConstants.textFieldBg;
  String _selectedTopic = 'Random';
  final TextEditingController _searchController = TextEditingController();
  final NewsApiService _newsApiService = NewsApiService();
  List<dynamic> _articles = [];
  final List<String> _categories = AppConstants.categories;
  List<dynamic> _firstArticlesPerCategory = [];

  @override
  void initState() {
    _fetchNews(_selectedTopic);
    _fetchCategoryNews();
    super.initState();
  }

  void _fetchNews(String topic) async {
    try {
      final articles = await _newsApiService.fetchNews(topic);
      print('Fetched articles: $articles'); // In ra dữ liệu để kiểm tra
      setState(() {
        _articles = articles;
      });
    } catch (e) {
      print('Fail to fetch news: $e');
    }
  }
  void _fetchCategoryNews() async
  {
    final firstArticlesPerCategory = await _newsApiService.fetchCategoryNews();
    setState(() {
      _firstArticlesPerCategory = firstArticlesPerCategory;
    });

  }

  void onClickTopic(String topic) {
    setState(() {
      _selectedTopic = topic;
    });
    _fetchNews(_selectedTopic);
  }

  void onBookmarkPress(dynamic article)
  {
    print('------------------------' + article);
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              // color: Colors.green,
              child: Text(
                        AppLocalizations.of(context)!.browse,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Container(
              // color: Colors.blue,
                height: 40,
                child: Text(
                  AppLocalizations.of(context)!.sloganHome,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppConstants.textColor
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
                    width: screenWidth - 40,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppConstants.textFieldBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: AppLocalizations.of(context)!.search,
                            controller: _searchController,
                            svgIconPath: 'assets/images/search.svg',
                          ),
                        ),
                        IconButton(
                          icon: SvgPicture.asset('assets/images/microphone.svg'),
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final topic = _categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: buildTopicButton(topic),
                );
              },
            ),
          ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(1,20,0,0),
            child: Container(
                    height: 256,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _firstArticlesPerCategory.length,
                      itemBuilder: (context, index) {
                        final article = _firstArticlesPerCategory[index];
                        final title = article['title'] is String ? article['title'] : 'No title';
                        final backgroundImage = article['image_url'] is String ? article['image_url'] : 'assets/images/imgDefaultNews.png';
                        final category = _categories[index].toUpperCase();

                        print("----------------------------- :" + category);
                        print(title + backgroundImage);
                        // print("Creator " + creator);
                        return CardHomeHorizontal(
                          backgroundImage: backgroundImage,
                          title: title,
                          category: category,
                          onBookmarkPress: () => onBookmarkPress(article) ,
                          onTap:()=>AppNavigator.navigateToScreen(context, ArticleDetailScreen(article: article)),
                        );
                      },
                    ),
                  ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 20),
          //   // child: Container(
          //   //   width: screenWidth - 40,
          //   //   height: screenHeight ,
          //   //   child: ListView.builder(
          //   //             itemCount: _articles.length,
          //   //             itemBuilder: (context, index) {
          //   //               final article = _articles[index];
          //   //               final title = article['title'] ?? 'No title';
          //   //               final img = article['image_url'] ?? 'assets/images/imgDefaultNews.png';
          //   //
          //   //               return CardHomeVertical(
          //   //                 backgroundImage: img,
          //   //                 title: title,
          //   //               );
          //   //             },
          //   //           ),
          //   // ),
          //
          // )
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.recommended,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: ( ){

                    },
                    child: Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: TextStyle(
                        color: AppConstants.textColor,
                      ),
                    )
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: _articles.map((article) {
                final title = article['title'] ?? 'No title';
                final img = article['image_url'] ?? 'assets/images/imgDefaultNews.png';
                return CardHomeVertical(
                  onBookmarkPress: (){},
                  onTap: () => AppNavigator.navigateToScreen(context, ArticleDetailScreen(article: article)),
                  backgroundImage: img,
                  title: title,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTopicButton(String topic) {
    return TextButton(
      onPressed: () {
        onClickTopic(topic);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
        backgroundColor: _selectedTopic == topic
            ? AppConstants.purplePrimary
            : AppConstants.textFieldBg,
      ),
      child: Text(
        topic,
        style: TextStyle(
          color: _selectedTopic == topic ? Colors.white : AppConstants.textColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
