import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_medium/day_3/models/post_model.dart';

class Day3Services {
  Future<List<PostModel>> getListPosts() async {
    Dio dio = Dio();

    try {
      final response = await dio
          .get("https://jsonplaceholder.typicode.com/posts");

      log("Response getListPosts $response");

      final List results = (response.data is List) ? response.data : [];

      return results.map((e) => PostModel.fromJson(e)).toList();
    } catch (error) {
      throw error;
    }
  }
}