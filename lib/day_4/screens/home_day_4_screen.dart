import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/list_post_day4_cubit.dart';

class HomeDay4Screen extends StatefulWidget {
  const HomeDay4Screen({Key? key}) : super(key: key);

  @override
  State<HomeDay4Screen> createState() => _HomeDay4ScreenState();
}

class _HomeDay4ScreenState extends State<HomeDay4Screen> {
  final _scrollController = ScrollController();

  bool isShowLoading = false;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET POSTS"),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          return _handleScrollNotification(
              scrollNotification: scrollNotification);
        },
        child: BlocBuilder<ListPostDay4Cubit, ListPostDay4State>(
          builder: (context, state) {
            if (state is ListPostDay4Loaded) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(children: [
                  ...state.posts
                      .asMap()
                      .map(
                        (key, value) => MapEntry(
                          key,
                          ListTile(
                            title: Text(value.title ?? "-"),
                            subtitle: Text(value.body ?? "-"),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                  (isShowLoading)
                      ? const SizedBox(
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ]),
              );
            } else if (state is ListPostDay4Empty) {
              return const Center(
                child: Text("List Posts is Empty"),
              );
            } else if (state is ListPostDay4Error) {
              return Center(
                child: Text(state.message ?? "-"),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  bool _handleScrollNotification({
    required ScrollNotification scrollNotification,
  }) {
    // Check Scroll Position
    if (scrollNotification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      // Set More Loading = true
      setState(() {
        isShowLoading = true;
        page += 1;
      });

      // More Posts
      context
          .read<ListPostDay4Cubit>()
          .loadMorePosts(
            page: page,
            limit: 20,
          )
          .then(
        (value) {
          // Set More Loading = false
          setState(() {
            isShowLoading = true;
          });
        },
      );
    }

    return false;
  }
}
