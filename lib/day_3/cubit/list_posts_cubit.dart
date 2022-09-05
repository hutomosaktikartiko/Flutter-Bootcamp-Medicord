import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/day_3_services.dart';

part 'list_posts_state.dart';

class ListPostsCubit extends Cubit<ListPostsState> {
  ListPostsCubit() : super(ListPostsInitial()) {
    getListPosts();
  }

  Future<void> getListPosts() async {
    Day3Services day3services = Day3Services();

    emit(ListPostsLoading());

    try {
      final List<PostModel> result = await day3services.getListPosts();

      if (result.isEmpty) {
        // Result < 1 || null
        emit(ListPostsEmpty());
      } else {
        emit(ListPostsLoaded(posts: result));
      }

    } catch (error) {
      emit(ListPostsError(message: error.toString()));
    }
  }
}
