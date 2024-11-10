
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class SaveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticlesRepository repository;

  SaveArticleUseCase({required this.repository});
  @override
  Future<void> call({ArticleEntity? params}) {
    return repository.saveArticle(params!);
  }
}