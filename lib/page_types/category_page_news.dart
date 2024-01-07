import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/category_date.dart';
import 'package:flutter_news_app/model/category_model.dart';
import 'package:flutter_news_app/model/news_modes.dart';
import 'package:flutter_news_app/helper/news_date.dart';

class CategoryFragment extends StatefulWidget {
  String category;
  CategoryFragment({required this.category});
  @override
  _CategoryFragmentState createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  //get news list
  List<ArticleModel> articles = [];
  bool _loading = true;

  getNews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.datatobesaved;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
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
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text(widget.category.toUpperCase(),
                style: TextStyle(color: Colors.black)),
          ),
        ]),
      ),

      //categories
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
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
            ),
    );
  }
}

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
