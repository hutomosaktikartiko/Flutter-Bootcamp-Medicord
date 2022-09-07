import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/list_posts_cubit.dart';

class HomeDay3Screen extends StatefulWidget {
  const HomeDay3Screen({Key? key}) : super(key: key);

  @override
  State<HomeDay3Screen> createState() => _HomeDay3ScreenState();
}

class _HomeDay3ScreenState extends State<HomeDay3Screen> {
  Future<void> _onRefresh() async {
    context.read<ListPostsCubit>().getListPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET POSTS"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<ListPostsCubit, ListPostsState>(
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
      ),
    );
  }
}
