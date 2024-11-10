import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constant.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

import '../data_sources/remote/news_api_service.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final NewsApiService newsApiService;
  final AppDatabase appDatabase;

  const ArticlesRepositoryImpl({
    required this.newsApiService,
    required this.appDatabase,
  });

  @override
  Future<DataState<List<ArticleModel>>> getArticles() async {
    final newsApiHttpResponse = await newsApiService.getNewsArticles(
      apiKey: newsApiKey,
      country: newsApiCountry,
      category: newsApiCategory,
    );
    try {
      if (newsApiHttpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(newsApiHttpResponse.data);
      } else {
        return DataFailure(DioException(
          requestOptions: newsApiHttpResponse.response.requestOptions,
          error: newsApiHttpResponse.response.statusMessage,
          response: newsApiHttpResponse.response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DataSuccess catch (e) {
      return DataFailure(e.data);
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) async{
    return appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<List<ArticleEntity>> getArticlesFromLocal() {
    return appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
