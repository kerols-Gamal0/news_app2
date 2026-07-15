import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/features/home/data/models/models.dart';

class ApiHelpers {
  // https://newsapi.org/v2/everything?q=apple&from=2026-07-13&to=2026-07-13&sortBy=popularity&apiKey=8d09c3ee8dfd4909a0196182fb75154e
  Future<Articles> getArticles() async {
    Uri url = Uri.https("newsapi.org", "/v2/everything", {
      "q": "apple",
      "from": "2026-07-13",
      "to": "2026-07-13",
      "sortBy": "popularity",
      "apiKey": "8d09c3ee8dfd4909a0196182fb75154e",
    });
    var response = await http.get(url);
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    return Articles.fromJson(json);
  }
}
