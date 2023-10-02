import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List _favoritesList = [];
  set favoritesList(List a) {
    _favoritesList = a;
    notifyListeners();
  }
}
