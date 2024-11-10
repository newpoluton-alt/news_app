import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/page_routes.dart';
import '../../bloc/article/remote/remote_article_bloc.dart';
import '../../bloc/article/remote/remote_article_state.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily News'),
        actions:[
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.pushNamed(context, savedArticlesRoute);
            },
          )
        ]
      ),
      body: BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
        builder: (_, state) {
          if (state is RemoteArticlesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemoteArticlesLoaded) {
            return ListView.builder(
              itemCount: state.articles!.length,
              itemBuilder: (context, index) {
                final article = state.articles![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, articleDetailsRoute,
                        arguments: article);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width:  100,
                        height: 150,
                        margin: const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors
                              .primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: article.urlToImage ?? '',
                            fit: BoxFit.fitHeight,
                            errorWidget: (_, __, ___) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Expanded(

                        child: ListTile(
                          title: Text(article.title ?? ''),
                          subtitle: Text(article.description ?? ''),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is RemoteArticlesError) {
            return const Center(
              child: Icon(Icons.refresh),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
