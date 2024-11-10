import 'package:equatable/equatable.dart';

import '../../../../domain/entities/article.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticleEvent({this.article});

  @override
  List<Object> get props => [article!];
}

class SaveArticleEvent extends LocalArticleEvent {
  const SaveArticleEvent({required ArticleEntity article}) : super(article: article);
}

class RemoveArticleEvent extends LocalArticleEvent {
  const RemoveArticleEvent({required ArticleEntity article}) : super(article: article);
}

class GetSavedArticlesEvent extends LocalArticleEvent {
  const GetSavedArticlesEvent();
}