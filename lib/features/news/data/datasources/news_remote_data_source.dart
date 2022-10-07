import 'package:dio/dio.dart';

import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<NewsModel>> getNews() async {
    try {
      final response = await dio.get(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=c178294463084054bae6b0896a2447c6");

      print("--- Response ---");
      print(response);

      final List result = (response.data['articles'] is List) ? response.data['articles'] : [];

      return result.map((e) => NewsModel.fromJson(e)).toList();
    } on DioError catch (error) {
      throw error;
    }
  }
}
