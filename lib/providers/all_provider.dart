import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List _favoritesList = [];
  set favoritesList(List a) {
    _favoritesList = a;
    notifyListeners();
  }

  String _categoryId = '0';

  String get categoryId => _categoryId;
  set categoryId(String a) {
    _categoryId = a;
    notifyListeners();
  }

  List _categoryList = [];
  List get categoryList => _categoryList;
  set categoryList(List a) {
    _categoryList = a;
    notifyListeners();
  }

  List _serchCategory = [];
  List get serchCategory => _serchCategory;
  set serchCategory(List a) {
    _serchCategory = a;
    notifyListeners();
  }

  List _getJobs = [];
  List get getJobs => _getJobs;
  set getJobs(List a) {
    _getJobs = a;
    notifyListeners();
  }

  int _navigationScreen = 0;
  int get navigationScreen => _navigationScreen;
  set navigationScreen(int index) {
    _navigationScreen = index;
    notifyListeners();
  }

  List _wallPaper = [];
  List get wallPaper => _wallPaper;
  set wallPaper(List a) {
    _wallPaper = a;
    notifyListeners();
  }

  bool _internet = false;
  bool get internet => _internet;
  set internet(bool a) {
    _internet = a;
    notifyListeners();
  }

}
