import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/online_data_source/api_manager.dart';
import 'package:news_mon_c9/data/model/articles_response.dart';
import 'package:news_mon_c9/data/model/sources_response.dart';
import 'package:news_mon_c9/ui/widgets/article_widget.dart';

class NewsList extends StatelessWidget {
  Source source;

  NewsList(this.source);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager().getArticles(source!.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildListView(snapshot.data!.articles!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildListView(List<Article> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index){
          return ArticleWidget(articles[index]);
        });
  }
}
