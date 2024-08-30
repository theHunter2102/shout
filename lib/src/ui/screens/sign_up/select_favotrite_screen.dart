  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:shout/src/ui/screens/sign_in_screen.dart';
  import '../../../config/constants.dart';
  import '../../../navigation/app_navigator.dart';
  import '../../widgets/custom_button.dart';
  import '../../widgets/favorite_topic_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
  class FavoriteSelect extends StatefulWidget {
    const FavoriteSelect({super.key});

    @override
    FavoriteSelectState createState() => FavoriteSelectState();
  }

  class FavoriteSelectState extends State<FavoriteSelect> {

    User? user = FirebaseAuth.instance.currentUser;
    // List<String> topics = ['🏈   Sports', '⚖️   Politics', '🌞   Life', '🎮   Gaming', '🐻   Animals', '🌴   Nature', '🍔   Food', '🎨   Art', '📜   History', '👗   Fashion',];

    List<bool> selectedTopic = [false,false,false,false,false,false,false,false,false,false,false,false,];

    void toggleSelection (int index)
    {
      setState(() {
        selectedTopic[index] = !selectedTopic[index];
      });
    }
    Future<void> setCategory (List<bool> categories) async {
      if(user != null){
        final userId = user!.uid;
        await FirebaseFirestore.instance.collection('categories').doc(userId).set({
          'categories' : categories
        });
      }
    }


    @override
    Widget build(BuildContext context) {
      List<String> topics =['🏈   ${AppLocalizations.of(context)!.sport}',
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
        '⚔️   ${AppLocalizations.of(context)!.east}'];
      double? screenHeight = AppConstants.screenHeight;

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            // padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  top: screenHeight! * 0.08,
                  left: 20,
                  right: 0,
                  child: Row(
                    children: [
                      Text(
                        'Select your favorite topics',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.13,
                  left: 20,
                  right: 0,
                  child: Text("Select some of your favorite topics to let us \n"
                      "suggest better news for you.",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppConstants.textColor
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  left: 20,
                  right: 20,
                  bottom: 0,
                  child: ListView(
                    children: [
                      for(int i = 0; i < topics.length; i+=2 )
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 16),
                              child: FavoriteTopicWidget(
                                  title: topics[i],
                                  isSelected: selectedTopic[i],
                                  onTap:() => toggleSelection(i),
                                color: AppConstants.textFieldBg,
                              ),
                            ),
                            if(i+1 < topics.length)
                              Container(
                                padding: EdgeInsets.only(bottom: 16),
                                child: FavoriteTopicWidget(
                                  title: topics[i+1],
                                  isSelected: selectedTopic[i+1],
                                  onTap:() => toggleSelection(i+1),
                                    color: AppConstants.textFieldBg
                                ),
                              )
                          ],
                        ),
                      CustomButton(
                        borderColor: Colors.transparent,
                        onPressed: ()  async {
                          await setCategory(selectedTopic);
                          AppNavigator.navigateToScreen(context, SignIn());
                        },
                        text: 'Next',
                      )
                    ],
                  ),
                ),
                // Positioned(
                //     top: screenHeight * 0.82,
                //     left: 20,
                //     right: 20,
                //     child:
                // ),
              ],
            ),
          )
        ),
      );
    }
  }
