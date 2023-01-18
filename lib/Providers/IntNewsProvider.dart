import 'package:flutter/cupertino.dart';
import 'package:newsapp/Models/api_service.dart';
import '../Models/article_model.dart';

class InternationalProvider with ChangeNotifier{

  List<ArticlesModel> articles = [];
  bool isLoading = true;

  final String _code = "us";


  InternationalProvider(){
    fetchBreakingNews();
  }


  Future<void> fetchBreakingNews()async{
    List storedArticles = await ApiClass.getTopNews(_code);
    List<ArticlesModel> temp = [];

    for(var article in storedArticles){
      ArticlesModel articlesModel = ArticlesModel.fromJson(article);
      temp.add(articlesModel);
    }
    articles = temp;
    isLoading = false;
    //print("Provider Called");
    //print(articles[0].title);
    notifyListeners();
  }
}