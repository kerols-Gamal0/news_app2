import 'package:flutter/material.dart';
import 'package:news_app/core/routes/routes.dart';
import 'package:news_app/features/home/data/api/api_helpers.dart';
import 'package:news_app/features/home/presentation/widgets/image_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        backgroundColor: Color(0xff1877F2),
        title: Text(
          'News App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiHelpers().getArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error fetching articles",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?.articles == null) {
            return const Center(
              child: Text(
                "No articles found",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            );
          }

          var snapshotData = snapshot.data?.articles;

          return ListView.builder(
            itemCount: snapshotData?.length,
            itemBuilder: (context, index) {
              final article = snapshotData?[index];
              final String articleImage = article?.urlToImage ?? dummyImage;
              final String articleTitle = article?.title ?? '';
              final String articleContent =
                  article?.description ??
                  article?.content ??
                  'No content available';
              final String? articleAuthor = article?.author;

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
                      'author': articleAuthor,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
