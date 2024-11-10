import "package:equatable/equatable.dart";

import "../../../../domain/entities/article.dart";

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({this.articles});

  @override
  List<Object> get props => [articles!];
}


class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesLoaded extends LocalArticlesState {
  const LocalArticlesLoaded({required List<ArticleEntity> articles}) : super(articles: articles);
}


class LocalArticlesError extends LocalArticlesState {
  const LocalArticlesError();
}


