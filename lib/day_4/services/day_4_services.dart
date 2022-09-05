import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/post_day_4_model.dart';

class Day4Services {
  Future<List<PostDay4Model>> getListPosts({
    required int page,
    required int limit,
  }) async {
    Dio dio = Dio();

    try {
      final response = await dio
          .get("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit");

      log("Response getListPosts $response");

      final List results = (response.data is List) ? response.data : [];

      return results.map((e) => PostDay4Model.fromJson(e)).toList();
    } catch (error) {
      throw error;
    }
  }
}