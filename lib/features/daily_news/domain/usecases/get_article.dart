import 'package:news_app/features/daily_news/domain/entities/article.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/article_repository.dart';

class GetArticlesUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticlesRepository articleRepository;

  const GetArticlesUseCase({required this.articleRepository});

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return articleRepository.getArticles();
  }
}
