import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);
  // Future<void> insertArticles(List<ArticleModel> articles);
  @delete
  Future<void> deleteArticle(ArticleModel article);
  // Future<void> deleteArticles(List<ArticleModel> articles);
  // Future<void> deleteAllArticles();

  @Query("SELECT * FROM articles")
  Future<List<ArticleModel>> getArticles();
}