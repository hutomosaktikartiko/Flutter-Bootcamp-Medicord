part of 'list_post_day4_cubit.dart';

@immutable
abstract class ListPostDay4State {}

class ListPostDay4Initial extends ListPostDay4State {}

class ListPostDay4Loading extends ListPostDay4State {}

class ListPostDay4Loaded extends ListPostDay4State {
  final List<PostDay4Model> posts;

  ListPostDay4Loaded({
    required this.posts,
  });
}

class ListPostDay4Empty extends ListPostDay4State {}

class ListPostDay4Error extends ListPostDay4State {
  final String? message;

  ListPostDay4Error({
    required this.message,
  });
}