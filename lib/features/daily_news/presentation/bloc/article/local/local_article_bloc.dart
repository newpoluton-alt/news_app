import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

import '../../../../domain/entities/article.dart';
import '../../../../domain/usecases/delete_article.dart';
import '../../../../domain/usecases/save_article.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticlesState> {
  final GetSavedArticleUseCase getSavedArticleUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final DeleteArticleUseCase deleteArticleUseCase;

  LocalArticleBloc({
    required this.getSavedArticleUseCase,
    required this.saveArticleUseCase,
    required this.deleteArticleUseCase,
  }) : super(const LocalArticlesLoading()) {
    on<GetSavedArticlesEvent>((event, emit) async => await onGetSavedArticles(emit: emit));
    on<SaveArticleEvent>((event, emit) async  => await onSaveArticle(saveArticle: event, emit: emit));
    on<RemoveArticleEvent>((event, emit) async => await onRemoveArticle(removeArticle: event, emit: emit));
  }


  Future<void> onGetSavedArticles({required Emitter<LocalArticlesState> emit}) async {
    final articles = await getSavedArticleUseCase();
    emit(LocalArticlesLoaded(articles: articles));
  }

  Future<void> onSaveArticle({required SaveArticleEvent saveArticle, required Emitter<
      LocalArticlesState> emit }) async {
    await saveArticleUseCase(params: saveArticle.article);
    await onGetSavedArticles(emit: emit);
  }

  Future<void> onRemoveArticle(
      {required RemoveArticleEvent removeArticle, required Emitter<
          LocalArticlesState> emit }) async {
    await deleteArticleUseCase(params: removeArticle.article);
    await onGetSavedArticles(emit: emit);
  }
}