import 'package:flutter_news_app/model/category_model.dart';

List<CategoryModel> getCategories() {
  // Create a new list
  List<CategoryModel> categories = [];

  CategoryModel category = CategoryModel(
      categoryName: 'Область',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/f/f6/Zakarpatska-Oblast.JPG');

  // Add categories
  category = CategoryModel(
    categoryName: 'Область',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/f/f6/Zakarpatska-Oblast.JPG',
  );
  categories.add(category);

  category = CategoryModel(
    categoryName: 'ТЦК',
    imageUrl: 'https://kp.ua/img/article/6828/42_news_big-v1704544731.webp',
  );
  categories.add(category);

  category = CategoryModel(
    categoryName: 'Культура',
    imageUrl: 'https://zakarpatoblarch.gov.ua/wp-content/uploads/2019/12/5.jpg',
  );
  categories.add(category);

  category = CategoryModel(
    categoryName: 'Туризм',
    imageUrl:
        'https://pmg.ua/static/content/thumbs/1200x630/2/44/xbp4n2---c1200x630x50px50p-up--18ac2c198334fe8756864b907b0b7442.jpg',
  );
  categories.add(category);

  return categories;
}
