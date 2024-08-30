// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../../config/constants.dart';
// import '../../widgets/favorite_topic_widget.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';
// class CategoryScreen extends StatefulWidget
// {
//   @override
//   State<StatefulWidget> createState() => CategoryScreenState();
//
//
// }
//
// class CategoryScreenState extends State<CategoryScreen> {
//
//   // List<String> _categories = AppConstants.categories;
//    late List<bool> _selectedCategory =[] ;
//   User? user = FirebaseAuth.instance.currentUser;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getSelectedCategory();
//   }
//
//   void toggleSelection (int index)
//   {
//     setState(() {
//       _selectedCategory[index] = !_selectedCategory[index];
//     });
//   }
//   Future<void> setCategory (List<bool> categories) async {
//     if(user != null){
//       final userId = user!.uid;
//       await FirebaseFirestore.instance.collection('categories').doc(userId).set({
//         'categories' : categories
//       });
//     }
//   }
//   Future<void> getSelectedCategory() async {
//     if(user != null){
//       DocumentSnapshot categoryData = await FirebaseFirestore.instance.collection('categories').doc(user!.uid).get();
//
//       List<dynamic> categories = categoryData['categories'] ?? [];
//       setState(() {
//         _selectedCategory = List<bool>.from(categories);
//         print('Category----------------------------------------------${_selectedCategory}');
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//   double? screenHeight = AppConstants.screenHeight;
//
//   List<String> _categories = [
//     '🏈   ${AppLocalizations.of(context)!.sport}',
//     '⚖️   ${AppLocalizations.of(context)!.politic}',
//     '🌞   ${AppLocalizations.of(context)!.life}',
//     '🎮   ${AppLocalizations.of(context)!.gaming}',
//     '🐻   ${AppLocalizations.of(context)!.animal}',
//     '🌴   ${AppLocalizations.of(context)!.nature}',
//     '🍔   ${AppLocalizations.of(context)!.food}',
//     '🎨   ${AppLocalizations.of(context)!.art}',
//     '📜   ${AppLocalizations.of(context)!.history}',
//     '👗   ${AppLocalizations.of(context)!.fashion}',
//     '😷   ${AppLocalizations.of(context)!.covid}',
//     '⚔️   ${AppLocalizations.of(context)!.east}'];
//
//
//     return Scaffold(
//     backgroundColor: Colors.white,
//     body: ListView(
//       padding: EdgeInsets.all(20),
//       children: [
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
//           child: Container(
//             alignment: Alignment.centerLeft,
//             height: 40,
//             child: Text(
//               AppLocalizations.of(context)!.categories,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 8),
//           child: Container(
//             height: 40,
//             child: Text(
//               AppLocalizations.of(context)!.categoriesSlogan,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: AppConstants.textColor,
//               ),
//             ),
//           ),
//         ),
//
//         _selectedCategory.isNotEmpty ?
//         Padding(
//           padding: EdgeInsets.only(top: 8),
//           child: Column(
//             children: [
//               for(int i = 0; i < _categories.length; i+=2)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: Container(
//                           decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Color(0xFFF3F4F6),
//                                           width: 1
//                                       ),
//                                       borderRadius: BorderRadius.circular(12)
//                                     ),
//                         child: FavoriteTopicWidget(
//                             title: _categories[i],
//                             isSelected: _selectedCategory[i],
//                             onTap: ()
//                             {
//                               toggleSelection(i);
//                             },
//                             color: Colors.white
//                         ),
//                       ),
//                     ),
//                     if(i+1 < _categories.length)
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 16),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Color(0xFFF3F4F6),
//                                   width: 1
//                               ),
//                               borderRadius: BorderRadius.circular(12)
//                           ) ,
//                           child: FavoriteTopicWidget(
//                               title: _categories[i+1],
//                               isSelected: _selectedCategory[i+1],
//                               onTap: ()
//                               {
//                                 toggleSelection(i+1);
//                               },
//                               color: Colors.white
//                           ),
//                         ),
//                       )
//                   ],
//                 )
//           ]
//           // Wrap(
//           //     spacing: 10,
//           //     runSpacing: 16,
//           //     children: List.generate(_categories.length, (index) {
//           //       return Container(
//           //         decoration: BoxDecoration(
//           //           border: Border.all(
//           //               color: Color(0xFFF3F4F6),
//           //               width: 1
//           //           ),
//           //           borderRadius: BorderRadius.circular(12)
//           //         ),
//           //         child: FavoriteTopicWidget(
//           //           color: Colors.white,
//           //           title: _categories[index],
//           //           isSelected: selectedCategory[index],
//           //           onTap: () {
//           //             toggleSelection(index);
//           //           },
//           //         ),
//           //       );
//           //     }),
//           //   ),
//           ),
//         )
//             :
//          Container(
//             height: 100,
//             width: 100,
//             margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/5),
//             // height: ,
//             child: const Center(
//               child: CircularProgressIndicator(
//               ),
//             ),
//           ),
//       ],
//     ),
//   );
//   }
//
//   @override
//   void dispose() {
//     setCategory(_selectedCategory);
//     super.dispose();
//   }
//
//
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../config/constants.dart';
import '../../widgets/favorite_topic_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  late Future<List<bool>> _selectedCategoryFuture;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _selectedCategoryFuture = getSelectedCategory();
  }

  Future<List<bool>> getSelectedCategory() async {
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

  void toggleSelection(int index, List<bool> categories) {
    setState(() {
      categories[index] = !categories[index];
      setCategory(categories);
    });
  }

  Future<void> setCategory(List<bool> categories) async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('categories').doc(user!.uid).set({
          'categories': categories,
        });
      } catch (e) {
        // Handle error
        print('Error setting categories: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _categories = [
      '🏈   ${AppLocalizations.of(context)!.sport}',
      '⚖️   ${AppLocalizations.of(context)!.politic}',
      '🌞   ${AppLocalizations.of(context)!.life}',
      '🎮   ${AppLocalizations.of(context)!.gaming}',
      '🐻   ${AppLocalizations.of(context)!.animal}',
      '🌴   ${AppLocalizations.of(context)!.nature}',
      '🍔   ${AppLocalizations.of(context)!.food}',
      '🎨   ${AppLocalizations.of(context)!.art}',
      '📜   ${AppLocalizations.of(context)!.history}',
      '👗   ${AppLocalizations.of(context)!.fashion}',
      '😷   ${AppLocalizations.of(context)!.covid}',
      '⚔️   ${AppLocalizations.of(context)!.east}',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<bool>>(
        future: _selectedCategoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading categories'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Category'));
          } else {
            List<bool> selectedCategories = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    child: Text(
                      AppLocalizations.of(context)!.categories,
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
                      AppLocalizations.of(context)!.categoriesSlogan,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppConstants.textColor,
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  (_categories.length / 2).ceil(),
                      (index) {
                    int i = index * 2;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (i < _categories.length)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF3F4F6), width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FavoriteTopicWidget(
                                title: _categories[i],
                                isSelected: selectedCategories[i],
                                onTap: () => toggleSelection(i, selectedCategories),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (i + 1 < _categories.length)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF3F4F6), width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FavoriteTopicWidget(
                                title: _categories[i + 1],
                                isSelected: selectedCategories[i + 1],
                                onTap: () => toggleSelection(i + 1, selectedCategories),
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
