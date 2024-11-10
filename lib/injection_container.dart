import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/usecases/delete_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

import 'features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'features/daily_news/data/repositories/article_repository.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final database =
      await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<Dio>(Dio());

  // Data sources
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repositories
  sl.registerSingleton<ArticlesRepository>(
      ArticlesRepositoryImpl(newsApiService: sl(), appDatabase: sl()));

  // Use cases
  sl.registerSingleton<GetArticlesUseCase>(
      GetArticlesUseCase(articleRepository: sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(repository: sl()));

  sl.registerSingleton<SaveArticleUseCase>(
      SaveArticleUseCase(repository: sl()));

  sl.registerSingleton<DeleteArticleUseCase>(
      DeleteArticleUseCase(repository: sl()));

  // Blocs
  sl.registerFactory<RemoteArticlesBloc>(
      () => RemoteArticlesBloc(getArticleUseCase: sl()));

  sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(
        getSavedArticleUseCase: sl(),
        saveArticleUseCase: sl(),
        deleteArticleUseCase: sl(),
      ));
}

