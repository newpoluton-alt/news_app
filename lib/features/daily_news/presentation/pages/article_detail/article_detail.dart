import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/local/local_article_bloc.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final article = arguments is List
        ? arguments[0] as ArticleEntity?
        : arguments as ArticleEntity?;
    final isSaved = arguments is List ? arguments[1] as bool : false;
    return BlocProvider<LocalArticleBloc>(
      create: (context) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
              builder: (context) => GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  )),
          title: const Text("Article Details"),
        ),
        floatingActionButton: isSaved
            ? const SizedBox()
            : FloatingActionButton(
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  sl<LocalArticleBloc>().saveArticleUseCase(params: article);
                  // show message that article is saved
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Article Saved!")));
                },
              ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article!.title!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              if (article.urlToImage != null)
                CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Author: ${article.author ?? "Unknown"}"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child:
                    Text("Published At: ${article.publishedAt ?? "Unknown"}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article.description ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article.content ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
