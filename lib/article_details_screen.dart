import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  final String? author;

  const ArticleDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        backgroundColor: Color(0xff1877F2),
        title: Text(
          'Details News',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,

            children: [
              SizedBox(height: 24),
              Image.network(
                image,
                width: double.infinity,
                height: 248,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    if (author != null && author!.isNotEmpty)
                      Text(
                        'By: $author',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    SizedBox(height: 16),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 16),

                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w400,
                        color: Colors.white,

                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
