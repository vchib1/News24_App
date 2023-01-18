import 'package:flutter/cupertino.dart';

class IndicatorProvider with ChangeNotifier{

  int _activeIndex = 0;

  int get activeIndex  => _activeIndex;

  getSelectedIndex(int index){
    _activeIndex = index;
    notifyListeners();
  }
}