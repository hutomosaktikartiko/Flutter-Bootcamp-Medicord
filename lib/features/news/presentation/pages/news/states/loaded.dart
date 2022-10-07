import 'package:flutter/material.dart';

import '../../../../data/models/news_model.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    super.key,
    required this.news,
  });

  final List<NewsModel> news;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: news
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              ListTile(
                title: Text(value.title ?? "-"),
                subtitle: Text(value.description ?? "-"),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
