import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shout/src/auth/user_auth/firebase_auth/firebase_auth_services.dart';
import 'package:shout/src/models/news_model.dart';
import 'package:shout/src/navigation/app_navigator.dart';
import 'package:shout/src/ui/screens/details/article_detail_screen.dart';
import 'package:shout/src/ui/screens/details/home_screen.dart';
import 'package:shout/src/ui/screens/details/main_screen.dart';
import '../../../config/constants.dart';
import '../../widgets/bookmark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<StatefulWidget> createState() => BookmarkScreenState();
}


class BookmarkScreenState extends State<BookmarkScreen> {

 final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
 User? user = FirebaseAuth.instance.currentUser;
 List<Map<String, dynamic>> articleBookmarks = [];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async{
   List<Map<String, dynamic>> bookmarks = await getBookmarks();
   setState(() {
     articleBookmarks = bookmarks;
   });
  }

 Future<List<Map<String, dynamic>>> getBookmarks() async{
   if(user != null){
     final userId = user!.uid;

     final bookmarksReference = FirebaseFirestore.instance.collection('bookmarks').doc(userId).collection('items');

     final getBookmarks = await bookmarksReference.get();

     articleBookmarks = getBookmarks.docs.map((doc) => doc.data()).toList();

     return articleBookmarks;
   }
   return [];
 }

  void refresh(){
   setState(() {
     fetchBookmarks();
   });
 }
 void showBookmarkDetail()
 {
   AppNavigator.navigateToScreen(context, MainScreen(index: 1  ,));
 }

   @override
   Widget build(BuildContext context) {
     double? screenHeight = AppConstants.screenHeight;
     return Scaffold(
       backgroundColor: Colors.white,
       body: ListView(
         padding: const EdgeInsets.all(20),
         children: [
           Padding(
             padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
             child: Container(
               alignment: Alignment.centerLeft,
               height: 40,
               child: Text(
                 AppLocalizations.of(context)!.bookmarks,
                 style: const TextStyle(
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
                 style: const TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.normal,
                   color: AppConstants.textColor,
                 ),
               ),
             ),
           ),
           articleBookmarks.isNotEmpty ?
              ListView.builder(
                 shrinkWrap: true,
                 itemCount: articleBookmarks.length,
                 itemBuilder: (context, index){
                   return Container(
                     margin: const EdgeInsets.only(top: 20),
                     child: BookmarkWidget(
                         // image: articleBookmarks[index]['urlToImage'],
                         // category: articleBookmarks[index]['urlToImage'],
                         // title: articleBookmarks[index]['urlToImage'],
                         // onTap: showBookmarkDetail
                         image: articleBookmarks[index]['urlToImage'],
                         category: articleBookmarks[index]['category'],
                         title: articleBookmarks[index]['title'],
                         onTap: showBookmarkDetail
                     ),
                   );
                 },
               )

         :
           Expanded(
               child: Container(
                 margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/5),
                 // height: ,
                 width: 256,
                 // color: Colors.blue,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const SizedBox(height: 8),
                     Container(
                       width: 72,
                       height: 72,
                       decoration: BoxDecoration(
                           color: AppConstants.bookmarkBgIcon,
                           borderRadius: BorderRadius.circular(72)
                       ),
                       child: const Image(
                           image: AssetImage('assets/images/book-alt.png')
                       ),
                     ),
                     const SizedBox(height: 20,),
                     Container(
                       width: 256,
                       child: const Text(
                         'You haven\'t saved any articles \nyet. Start reading '
                             'and \nbookmarking them now',
                         style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.normal,
                           color: AppConstants.textColor,
                         ),
                         textAlign: TextAlign.center,
                       ),
                     )
                   ],
                 ),
               ),
           )


         ],
       ),
     );
   }
 }

