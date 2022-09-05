part of 'list_posts_cubit.dart';

@immutable
abstract class ListPostsState {}

class ListPostsInitial extends ListPostsState {}

class ListPostsLoading extends ListPostsState {}

class ListPostsLoaded extends ListPostsState {
  final List<PostModel> posts;

  ListPostsLoaded({
    required this.posts,
  });
}

class ListPostsEmpty extends ListPostsState {}

class ListPostsError extends ListPostsState {
  final String? message;

  ListPostsError({
    required this.message,
  });
}