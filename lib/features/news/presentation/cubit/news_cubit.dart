import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/news_model.dart';
import '../../data/repositories/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({
    required this.newsRepository,
  }) : super(NewsInitial());

  final NewsRepository newsRepository;

  Future<void> getNews() async {
    emit(NewsLoading());
    try {
      final List<NewsModel> result =await newsRepository.getNews();

      if (result.isEmpty) {
        emit(NewsEmpty());
      } else {
        emit(NewsLoaded(news: result));
      }
    } catch (error) {
      emit(NewsLoadingFailure(message: error.toString()));
    }
  }
}
