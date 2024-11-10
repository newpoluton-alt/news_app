
import 'package:news_app/features/daily_news/domain/entities/article.dart';

import '../../../../core/resources/data_state.dart';

abstract class ArticlesRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();

  Future<List<ArticleEntity>> getArticlesFromLocal();
  Future<void> saveArticle(ArticleEntity article);
  Future<void> deleteArticle(ArticleEntity article);
}