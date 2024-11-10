
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticlesRepository repository;

  GetSavedArticleUseCase({required this.repository});
  @override
  Future<List<ArticleEntity>> call({void params}) {
  return repository.getArticlesFromLocal();
  }
}