import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/routes/routes.dart';
import 'package:news_app/core/base_state/base_state_builder.dart';
import 'package:news_app/features/home/data/models/models.dart';
import 'package:news_app/features/home/presentation/widgets/image_item_widget.dart';
import 'package:news_app/features/home/presentation_model/news_cubit.dart';
import 'package:news_app/features/home/repo/data_source/home_data_source_implementation.dart';
import 'package:news_app/features/home/repo/repo/home_repo_implementatoin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(
            HomeRepoImplementation(HomeDataSourceImplementation()),
          )..fetchNews(),
      child: Scaffold(
        backgroundColor: const Color(0xff202020),
        appBar: AppBar(
          backgroundColor: const Color(0xff1877F2),
          title: const Text(
            'News App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return BaseStateBuilder<Articles>(
              state: state.fetchNewsState,
              onSuccess: (newsContainer) {
                final articlesList = newsContainer.articles ?? [];

                if (articlesList.isEmpty) {
                  return const Center(
                    child: Text(
                      "No articles available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: articlesList.length,
                  itemBuilder: (context, index) {
                    final article = articlesList[index];

                    final String articleImage =
                        article.urlToImage ?? dummyImage;
                    final String articleTitle = article.title ?? 'No Title';
                    final String articleContent =
                        article.description ??
                        article.content ??
                        'No content available';

                    return ImageItemWidget(
                      image: articleImage,
                      title: articleTitle,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.articleDetails,
                          arguments: {
                            'image': articleImage,
                            'title': articleTitle,
                            'content': articleContent,
                            'author': article.author,
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
