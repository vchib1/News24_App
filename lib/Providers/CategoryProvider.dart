import 'package:flutter/material.dart';
import '../Models/api_service.dart';
import '../Models/category_news_model.dart';

class CategoryProvider with ChangeNotifier{

  List<CategoryNewsModel> categoryNews = [];
  bool isLoading = true;
  int _current = 0;
  int get current => _current;

  String _code = "general";
  //String get codeName => _code;

  CategoryProvider(){
    fetchCategoryNews();
  }

  getCategoryName(String name){
    _code = name;
    notifyListeners();
  }

  currentMethod(int index){
    _current = index;
    notifyListeners();
  }

  Future<void> fetchCategoryNews()async{
    List storedNews = await ApiClass.getCategorizedNews(_code);
    List<CategoryNewsModel> temp = [];

    for(var categoryNew in storedNews){
      CategoryNewsModel categoryNewsModel = CategoryNewsModel.fromJson(categoryNew);
      temp.add(categoryNewsModel);
    }
    categoryNews = temp;
    isLoading = false;
    notifyListeners();
  }

}