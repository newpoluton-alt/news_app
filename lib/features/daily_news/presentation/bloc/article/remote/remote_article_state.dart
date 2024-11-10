import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class RemoteArticlesState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? exception;
  const RemoteArticlesState({this.articles, this.exception});

  @override
  List<Object?> get props => [articles, exception];
}

class RemoteArticlesLoading extends RemoteArticlesState{
  const RemoteArticlesLoading();
}

class RemoteArticlesLoaded extends RemoteArticlesState{
  const RemoteArticlesLoaded({required List<ArticleEntity> articles}) : super(articles: articles);
}

class RemoteArticlesError extends RemoteArticlesState{
  const RemoteArticlesError({required DioException exception}) : super(exception: exception);
}