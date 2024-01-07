import 'package:flutter/material.dart';
import 'package:flutter_news_app/page_types/main_page_news.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
    },
  ));
}
