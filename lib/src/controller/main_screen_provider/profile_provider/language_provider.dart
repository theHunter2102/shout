import 'package:flutter/cupertino.dart';

class languageChange extends ChangeNotifier{

  String _language = 'en';

  String get  language => _language;

  set language(String value) {
    _language = value;
  }


  void onChangeLanguage(String language){
    _language = language;
    notifyListeners();
}
}