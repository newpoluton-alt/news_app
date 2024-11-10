
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class DeleteArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticlesRepository repository;

  DeleteArticleUseCase({required this.repository});
  @override
  Future<void> call({ArticleEntity? params}) {
    return repository.deleteArticle(params!);
  }
}