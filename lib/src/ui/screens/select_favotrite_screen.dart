import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../my_app.dart';
import '../../navigation/app_navigator.dart';
import '../widgets/custom_button.dart';
import '../widgets/favorite_topic_widget.dart';

class FavoriteSelect extends StatefulWidget {
  @override
  FavoriteSelectState createState() => FavoriteSelectState();
}

class FavoriteSelectState extends State<FavoriteSelect> {

  List<String> topics = ['🏈   Sports', '⚖️   Politics', '🌞   Life', '🎮   Gaming', '🐻   Animals', '🌴   Nature', '🍔   Food', '🎨   Art', '📜   History', '👗   Fashion',];
  List<bool> selectedTopic = [false,false,false,false,false,false,false,false,false,false,];

  void toggleSelection (int index)
  {
    setState(() {
      selectedTopic[index] = !selectedTopic[index];
    });
  }

  @override
  Widget build(BuildContext context) {

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
                      onPressed: (){
                        AppNavigator.navigateToScreen(context, MyApp());
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
