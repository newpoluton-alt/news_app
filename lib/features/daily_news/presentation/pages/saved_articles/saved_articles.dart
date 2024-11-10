import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';

import '../../../../../core/routes/page_routes.dart';
import '../../../../../injection_container.dart';
import '../../bloc/article/local/local_article_state.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalArticleBloc>(
      create: (context) =>
          sl<LocalArticleBloc>()..add(const GetSavedArticlesEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
              builder: (context) => GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  )),
          title: const Text('Saved Articles'),
        ),
        body: BlocBuilder<LocalArticleBloc, LocalArticlesState>(
          builder: (context, state) {
            if (state is LocalArticlesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocalArticlesLoaded) {
              return ListView.builder(
                itemCount: state.articles!.length,
                itemBuilder: (context, index) {
                  final article = state.articles![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, articleDetailsRoute,
                          arguments: [article, true]);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 150,
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 15, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: article.urlToImage ?? '',
                              fit: BoxFit.fitHeight,
                              errorWidget: (_, __, ___) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(article.title ?? ''),
                            subtitle: Text(article.description ?? ''),
                            trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context.read<LocalArticleBloc>().add(RemoveArticleEvent(article: article));
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Article removed!')));

                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No articles saved'));
            }
          },
        ),
      ),
    );
  }
}
