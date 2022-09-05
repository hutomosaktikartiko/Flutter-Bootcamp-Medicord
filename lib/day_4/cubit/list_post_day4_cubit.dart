import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/post_day_4_model.dart';
import '../services/day_4_services.dart';

part 'list_post_day4_state.dart';

class ListPostDay4Cubit extends Cubit<ListPostDay4State> {
  ListPostDay4Cubit() : super(ListPostDay4Initial()) {
    getListPosts(page: 1, limit: 10);
  }

  Future<void> getListPosts({
    required int page,
    required int limit,
  }) async {
    Day4Services day4services = Day4Services();

    emit(ListPostDay4Loading());

    try {
      final List<PostDay4Model> result = await day4services.getListPosts(
        page: page,
        limit: limit,
      );

      if (result.isEmpty) {
        // Result < 1 || null
        emit(ListPostDay4Empty());
      } else {
        emit(ListPostDay4Loaded(posts: result));
      }
    } catch (error) {
      emit(ListPostDay4Error(message: error.toString()));
    }
  }

  Future<void> loadMorePosts({
    required int page,
    required int limit,
  }) async {
    Day4Services day4services = Day4Services();

    // Delayed 
    await Future.delayed(const Duration(seconds: 5));

    final List<PostDay4Model> result = await day4services.getListPosts(
      page: page,
      limit: limit,
    );

    if (result.isNotEmpty) {
      final List<PostDay4Model> lastPostsData = (state as ListPostDay4Loaded).posts;
      emit(ListPostDay4Loaded(posts: lastPostsData + result));
    }
  }
}
