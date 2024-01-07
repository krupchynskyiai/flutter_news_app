import 'dart:convert';

import 'package:flutter_news_app/model/news_modes.dart';
import 'package:http/http.dart';

class News {
  List<ArticleModel> datatobesaved = [];

  Future<void> getNews() async {
    var response = await get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=09ae0be177884484bb013b50dea174c1'));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['title'] != null &&
            element['url'] != null) {
          //initialize model class

          ArticleModel articleModel = ArticleModel(
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              title: element['title']);

          datatobesaved.add(articleModel);
        }
      });
    }
  }
}

//get news by categories
class CategoryNews {
  List<ArticleModel> datatobesaved = [];

  Future<void> getNews(String category) async {
    var response = await get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=09ae0be177884484bb013b50dea174c1'));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          //initialize model class

          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']);

          datatobesaved.add(articleModel);
        }
      });
    }
  }
}
