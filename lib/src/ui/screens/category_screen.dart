import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../widgets/favorite_topic_widget.dart';

class CategoryScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return CategoryScreenState();
  }

}

class CategoryScreenState extends State<CategoryScreen> {

  // List<String> _categories = AppConstants.categories;
  List<String> _categories = ['🏈   Sports', '⚖️   Politics', '🌞   Life', '🎮   Gaming', '🐻   Animals', '🌴   Nature', '🍔   Food', '🎨   Art', '📜   History', '👗   Fashion','😷   Covid-19','⚔️   Middle East'];
  List<bool> selectedCategory = [false,false,false,false,false,false,false,false,false,false,false,false,];

  void toggleSelection (int index)
  {
    setState(() {
      selectedCategory[index] = !selectedCategory[index];
    });
  }

  @override
  Widget build(BuildContext context) {
  double? screenHeight = AppConstants.screenHeight;
  return Scaffold(
    backgroundColor: Colors.white,
    body: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 52, 0, 0),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 40,
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Container(
            height: 40,
            child: Text(
              'Thousands of articles in each category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppConstants.textColor,
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: [
              for(int i = 0; i < _categories.length; i+=2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                          decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFF3F4F6),
                                          width: 1
                                      ),
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                        child: FavoriteTopicWidget(
                            title: _categories[i],
                            isSelected: selectedCategory[i],
                            onTap: ()
                            {
                              toggleSelection(i);
                            },
                            color: Colors.white
                        ),
                      ),
                    ),
                    if(i+1 < _categories.length)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFF3F4F6),
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(12)
                          ) ,
                          child: FavoriteTopicWidget(
                              title: _categories[i+1],
                              isSelected: selectedCategory[i+1],
                              onTap: ()
                              {
                                toggleSelection(i+1);
                              },
                              color: Colors.white
                          ),
                        ),
                      )
                  ],
                )
          ]
          // Wrap(
          //     spacing: 10,
          //     runSpacing: 16,
          //     children: List.generate(_categories.length, (index) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //               color: Color(0xFFF3F4F6),
          //               width: 1
          //           ),
          //           borderRadius: BorderRadius.circular(12)
          //         ),
          //         child: FavoriteTopicWidget(
          //           color: Colors.white,
          //           title: _categories[index],
          //           isSelected: selectedCategory[index],
          //           onTap: () {
          //             toggleSelection(index);
          //           },
          //         ),
          //       );
          //     }),
          //   ),
          ),
        )
      ],
    ),
  );
  }
}
