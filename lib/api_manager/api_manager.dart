import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_mon_c9/model/articles_response.dart';
import 'package:news_mon_c9/model/sources_response.dart';

abstract class ApiManager {
  static const String apiKey = "a2803275cc264f5ab82151862011361a";
  static const String baseUrl = "newsapi.org";

  static Future<SourcesResponse> getSources(String categoryId) async {
    try {
      Response response = await get(Uri.parse(
          "https://newsapi.org/v2/top-headlines/sources?apiKey=a2803275cc264f5ab82151862011361a&&category=$categoryId"));
      print(response.body);

      SourcesResponse sourcesResponse =
          SourcesResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300
          && sourcesResponse.sources?.isNotEmpty == true) {
        return sourcesResponse;
      } else {
        throw Exception(sourcesResponse.message ??
            "Something went wrong please try again later");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<ArticlesResponse> getArticles(String sourceId) async {
    try {
      Uri url = Uri.https(
          baseUrl, "v2/everything", {"apiKey": apiKey, "sources": sourceId});
      Response response = await get(url);
      ArticlesResponse articlesResponse =
          ArticlesResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          articlesResponse.articles?.isNotEmpty == true) {
        return articlesResponse;
      } else {
        throw Exception(articlesResponse.message ?? "Something went...");
      }
    } catch (_) {
      rethrow;
    }
  }
}
