import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/news_cubit.dart';
import 'states/empty.dart';
import 'states/loading.dart';
import 'states/loaded.dart';
import 'states/error.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _getData() async {
    context.read<NewsCubit>().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getData,
        child: ListView(
          children: [
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoaded) {
                  return Loaded(
                    news: state.news,
                  );
                } else if (state is NewsEmpty) {
                  return const Empty();
                } else if (state is NewsLoadingFailure) {
                  return Error(
                    message: state.message,
                  );
                }

                return const Loading();
              },
            ),
          ],
        ),
      ),
    );
  }
}
