import 'package:flutter/cupertino.dart';
import '../Models/api_service.dart';
import '../Models/category_news_model.dart';

class SearchedNewsProvider with ChangeNotifier {

  List<CategoryNewsModel> searchedNews = [];
  bool isLoading = true;

  String _searchedQuery = "";

  String get searchedQuery => _searchedQuery;

  getSearchValue(String value) {
    _searchedQuery = value;
    fetchSearchedNews();
    notifyListeners();
  }

  Future<void> fetchSearchedNews() async {
    List storedSearchedNews = await ApiClass.getSearchedNews(_searchedQuery);
    List<CategoryNewsModel> temp = [];

    for (var searchedNew in storedSearchedNews) {
      CategoryNewsModel categoryNewsModel = CategoryNewsModel.fromJson(searchedNew);
      temp.add(categoryNewsModel);
    }
    searchedNews = temp;
    isLoading = false;
    notifyListeners();
  }
}
