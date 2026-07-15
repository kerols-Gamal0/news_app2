import 'package:flutter/material.dart';
import 'package:news_app/core/theme/theme.dart';
import 'package:news_app/features/details/presentation/screens/article_details_screen.dart';
import 'package:news_app/features/home/presentation/screens/home_screen.dart';
import 'package:news_app/core/routes/routes.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppData.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomeScreen(),

        Routes.articleDetails: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return ArticleDetailsScreen(
            image: args['image'],
            title: args['title'],
            content: args['content'],
            author: args['author'],
          );
        },
      },
    );
  }
}
