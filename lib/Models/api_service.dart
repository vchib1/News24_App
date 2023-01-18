import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiClass {
  static Future<void> deleteCache() async {
    var dir = await getTemporaryDirectory();
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }

  //API for Top News
  static Future<List<dynamic>> getTopNews(String country) async {
    try {
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=$country&apiKey=c760583740784a958e00124a73857183"));
      var decodedResponse = jsonDecode(response.body);
      List breakingNews = decodedResponse['articles'];
      return breakingNews;
    } catch (e) {
      return [];
    }
  }

  //API for category
  static Future<List<dynamic>> getCategorizedNews(String category) async {
    String general = "general.json";
    String business = "business.json";
    String entertainment = "entertainment.json";
    String health = "health.json";
    String science = "science.json";
    String sports = "sports.json";
    String technology = "technology.json";

    var dir = await getTemporaryDirectory();
    File fileGeneral = File("${dir.path}/$general");
    File fileBusiness = File("${dir.path}/$business");
    File fileEntertainment = File("${dir.path}/$entertainment");
    File fileHealth = File("${dir.path}/$health");
    File fileScience = File("${dir.path}/$science");
    File fileSports = File("${dir.path}/$sports");
    File fileTechnology = File("${dir.path}/$technology");

    if (fileGeneral.existsSync() && category == "General") {
      var jsonData = fileGeneral.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else if (fileBusiness.existsSync() && category == "Business") {
      var jsonData = fileBusiness.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else if (fileEntertainment.existsSync() && category == "Entertainment") {
      var jsonData = fileEntertainment.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else if (fileHealth.existsSync() && category == "Health") {
      var jsonData = fileHealth.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else if (fileScience.existsSync() && category == "Science") {
      var jsonData = fileScience.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else if (fileSports.existsSync() && category == "Sports") {
      var jsonData = fileSports.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else if (fileTechnology.existsSync() && category == "Technology") {
      var jsonData = fileTechnology.readAsStringSync();
      var decodedResponse = jsonDecode(jsonData);
      List categoryNews = decodedResponse['articles'];
      return categoryNews;
    } else {
      try {
        final response = await http.get(Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=c760583740784a958e00124a73857183"));
        var decodedResponse = jsonDecode(response.body);
        List categoryNews = decodedResponse['articles'];
        if (category == "General") {
          fileGeneral.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        if (category == "Business") {
          fileBusiness.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        if (category == "Entertainment") {
          fileEntertainment.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        if (category == "Health") {
          fileHealth.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        if (category == "Science") {
          fileScience.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        if (category == "Sports") {
          fileSports.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        if (category == "Technology") {
          fileTechnology.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        }
        return categoryNews;
      } catch (e) {
        return [];
      }
    }
  }

  //API for Search
  static Future<List<dynamic>> getSearchedNews(String search) async {
    DateTime today = DateTime.now();
    String link = search.replaceAll(" ", "-").toLowerCase();

    try {
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=$link&from=${today.year}-${today.month}-${today.day}&sortBy=popularity&apiKey=c760583740784a958e00124a73857183"));
      var decodedResponse = jsonDecode(response.body);
      List searchedNews = decodedResponse['articles'];
      return searchedNews;
    } catch (e) {
      return [];
    }
  }
}
