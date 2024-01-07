import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/category_date.dart';
import 'package:flutter_news_app/model/category_model.dart';
import 'package:flutter_news_app/model/news_modes.dart';
import 'package:flutter_news_app/helper/news_date.dart';
import 'package:flutter_news_app/page_types/category_page_news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get categories list

  List<CategoryModel> categories = [];

  //get news list
  List<ArticleModel> articles = [];
  bool _loading = true;

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesaved;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text('Моє Закарпаття ', style: TextStyle(color: Colors.black)),
          Text('Всі новини', style: TextStyle(color: Colors.blueAccent)),
        ]),
      ),

      //categories
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              categoryName: categories[index].categoryName,
                              imageUrl: categories[index].imageUrl,
                            );
                          },
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: articles.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return NewsTemplate(
                                urlToImage: articles[index].urlToImage,
                                title: articles[index].title,
                                description: articles[index].description,
                                url: articles[index].url);
                          },
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl;
  CategoryTile({required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryFragment(category: categoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 150,
                  height: 80,
                  fit: BoxFit.cover),
            ),
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black45,
              ),
              child: Text(categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//template for news
class NewsTemplate extends StatelessWidget {
  String title, description, url, urlToImage;
  NewsTemplate(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                  imageUrl: urlToImage,
                  width: 380,
                  height: 200,
                  fit: BoxFit.cover)),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 15.0, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
