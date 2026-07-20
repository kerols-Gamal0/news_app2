import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/home/data/models/models.dart';
import 'package:news_app/features/home/repo/data_source/home_data_source_interface.dart';

class HomeDataSourceImplementation implements HomeDataSourceInterface {
  @override
  Future<BaseState<Articles>> getArticles() async {
    try {
      Uri url = Uri.https("newsapi.org", "/v2/everything", {
        "q": "apple",
        "from": "2026-07-13",
        "to": "2026-07-13",
        "sortBy": "popularity",
        "apiKey": "8d09c3ee8dfd4909a0196182fb75154e",
      });

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        var data = Articles.fromJson(json);

        if (data.articles != null && data.articles!.isNotEmpty) {
          final validArticles = data.articles!
              .where(
                (article) =>
                    article.urlToImage != null &&
                    article.urlToImage!.isNotEmpty,
              )
              .toList();

          return BaseSuccessState<Articles>(
            data: Articles(articles: validArticles),
          );
        } else {
          return const BaseFailureState<Articles>(
            errorMessage: "No articles found.",
          );
        }
      } else {
        return BaseFailureState<Articles>(
          errorMessage: "Server Error with status code: ${response.statusCode}",
        );
      }
    } on SocketException {
      return const BaseFailureState<Articles>(
        errorMessage: "No Internet Connection. Please check your network.",
      );
    } catch (e) {
      print("Error inside getArticles: $e");
      return const BaseFailureState<Articles>(
        errorMessage: "Something went wrong. Please try again later.",
      );
    }
  }
}
