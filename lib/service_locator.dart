import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/error/interceptor_info.dart';
import 'core/network/network_info.dart';
import 'features/news/data/datasources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository.dart';
import 'features/news/presentation/cubit/news_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Feature News
  await _news();

  // Core
  await _core();

  // External
  await _external();
}

Future<void> _news() async {
  // Datasources
  serviceLocator.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(dio: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
      networkInfo: serviceLocator(), newsRemoteDataSource: serviceLocator()));

  // Cubit
  serviceLocator.registerFactory<NewsCubit>(
      () => NewsCubit(newsRepository: serviceLocator()));
}

Future<void> _core() async {
  //  Network Info
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: serviceLocator()));
}

Future<void> _external() async {
  // Connectivity Plus
  serviceLocator.registerLazySingleton<Connectivity>(() => Connectivity());

  // Dio
  serviceLocator.registerLazySingleton<Dio>(
      () => Dio()..interceptors.add(InterceptorInfo()));
}
