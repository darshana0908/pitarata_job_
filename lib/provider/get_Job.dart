import 'package:flutter/material.dart';

class getJobId with ChangeNotifier {
  int _index = 0;

  int get isIndex => _index;

  void change(int index) {
    _index = index;
    notifyListeners();


  }
   
}