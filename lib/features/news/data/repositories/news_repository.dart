import '../../../../core/network/network_info.dart';
import '../datasources/news_remote_data_source.dart';
import '../models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getNews();
}

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.networkInfo,
    required this.newsRemoteDataSource,
  });

  @override
  Future<List<NewsModel>> getNews() async {
    if (await networkInfo.isConnected) {
      // Online
      try {
        final List<NewsModel> result = await newsRemoteDataSource.getNews();

        return result;
      } catch (error) {
        throw error.toString();
      }
    } else {
      // Offline
      throw "No connection";
    }
  }
}