import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/constants.dart';
import '../../../navigation/app_navigator.dart';
import '../../../services/news_api_service.dart';
import '../../widgets/card_home_screen_horizontal.dart';
import '../../widgets/card_home_screen_vertical.dart';
import '../../widgets/custom_text_field.dart';
import 'article_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>  HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Color _fieldColor = AppConstants.textFieldBg;
  final Color _statusTextColor = AppConstants.textFieldBg;
  String _selectedTopic = 'Random';
  final TextEditingController _searchController = TextEditingController();
  final NewsApiService _newsApiService = NewsApiService();
  List<dynamic> _articles = [];
  List<String> _categories = [];
  final List<String> _categoriesTopic = AppConstants.categories;
  List<dynamic> _firstArticlesPerCategory = [];
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, bool> _bookmarksStatus= {};
  late Future<List<bool>> _selectedCategoryFuture;

  @override
  void initState() {
    _fetchNews(_selectedTopic);
    _fetchCategoryNews();
    // _selectedCategoryFuture = getCategory();
    getCategories();
    super.initState();
  }

  Future<List<bool>> getCategory() async{
    if (user != null) {
      try {
        DocumentSnapshot categoryData = await FirebaseFirestore.instance
            .collection('categories')
            .doc(user!.uid)
            .get();

        List<dynamic> categories = categoryData['categories'] ?? [];
        return List<bool>.from(categories);
      } catch (e) {
        // Handle error
        print('Error fetching categories: $e');
      }
    }
    return [];
  }

  void getCategories () async{

    _selectedCategoryFuture = getCategory();

    List<bool> selectedCategory = await _selectedCategoryFuture;

    for(int i = 0 ; i < selectedCategory.length; i++){
      if(selectedCategory[i]){
        _categories.add(AppConstants.categories[i]);
      }
    }
  }

  void seeAll(){
    setState(() {
      _categories = AppConstants.categories;
    });
  }
  void _fetchNews(String topic) async {
    try {
      final articles = await _newsApiService.fetchNews(topic);
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




  Future<void> addBookMark(String link, String urlToImage, String category, String title) async{
    if (user != null) {
      final userId = user!.uid;
       final bookmarkReference = FirebaseFirestore.instance.collection('bookmarks').doc(userId).collection('items');

      final checkDouble = await bookmarkReference.where('link',isEqualTo: link).get();
      if(checkDouble.docs.isEmpty){
        await bookmarkReference.add({
          'link': link,
          'urlToImage' : urlToImage,
          'category' : category,
          'title' : title
        });
        setState(() {
          _bookmarksStatus[link] = true;
        });
      }
      else{
        await bookmarkReference.doc(checkDouble.docs.first.id).delete();
        setState(() {
          _bookmarksStatus[link] = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
              Padding(
                padding: const EdgeInsets.only(top: 32),
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
                itemCount: _categoriesTopic.length,
                itemBuilder: (context, index) {
                  final topic = _categoriesTopic[index];
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
                          final category = AppConstants.categories[index].toUpperCase();
                          final link = article['link'];

                          print("----------------------------- :" + category);
                          print(title + backgroundImage);
                          // print("Creator " + creator);
                          return CardHomeHorizontal(
                            colorBookmarkIcon: _bookmarksStatus[link] == true ? AppConstants.purplePrimary : Colors.white,
                            backgroundImage: backgroundImage,
                            title: title,
                            category: category,
                            onBookmarkPress: () => addBookMark(link, backgroundImage, category, title) ,
                            onTap:()=>AppNavigator.navigateToScreen(context, ArticleDetailScreen(article: article)),
                          );
                        },
                      ),
                    ),
            ),
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
                        seeAll();
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
                  final link = article['link'];
                  final category = article['category'][0].toString().toUpperCase();
                  return CardHomeVertical(
                    onBookmarkPress: (){
                      addBookMark(link, img, category, title);
                    },
                    onTap: () => AppNavigator.navigateToScreen(context, ArticleDetailScreen(article: article)),
                    backgroundImage: img,
                    title: title,
                    colorBookmarkIcon: _bookmarksStatus[link] == true ? AppConstants.purplePrimary : AppConstants.textColor,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
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
