import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/list_posts_cubit.dart';

class HomeDay3Screen extends StatelessWidget {
  const HomeDay3Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET POSTS"),
        centerTitle: true,
      ),
      body: BlocBuilder<ListPostsCubit, ListPostsState>(
        builder: (context, state) {
          if (state is ListPostsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: state.posts
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
              ),
            );
          } else if (state is ListPostsEmpty) {
            return const Center(
              child: Text("List Posts is Empty"),
            );
          } else if (state is ListPostsError) {
            return Center(
              child: Text(state.message ?? "-"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
