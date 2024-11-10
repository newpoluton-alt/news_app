import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/themes/app_themes.dart';
import 'package:news_app/core/routes/page_routes.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_app/injection_container.dart';

import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';
import 'features/daily_news/presentation/pages/saved_articles/saved_articles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<RemoteArticlesBloc>(
      create: (context) =>
      sl<RemoteArticlesBloc>()..add(const GetArticles()),
      child: MaterialApp(
        routes: {
          articleDetailsRoute: (context) => const ArticleDetailsView(),
          savedArticlesRoute: (context) => const SavedArticles(),
        },
        title: 'News App',
        theme: themeData(),
        home: const DailyNews(),
      ),
    );
  }
}
