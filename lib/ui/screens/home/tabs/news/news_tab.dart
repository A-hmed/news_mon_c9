import 'package:flutter/material.dart';
import 'package:news_mon_c9/api_manager/api_manager.dart';
import 'package:news_mon_c9/model/category_dm.dart';
import 'package:news_mon_c9/model/sources_response.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/news/news_list.dart';

class NewsTab extends StatefulWidget {
  String categoryId;
  NewsTab({required this.categoryId});
  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getSources(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return buildTabs(snapshot.data!.sources!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildTabs(List<Source> sources) {
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          TabBar(
              onTap: (index) {
                currentTab = index;
                setState(() {});
              },
              indicatorColor: Colors.transparent,
              isScrollable: true,
              tabs: sources.map((singleSource) => buildTab(singleSource,
                   sources.indexOf(singleSource) == currentTab)).toList()),
          Expanded(
            child: TabBarView(
                children: sources
                    .map((singleSource) => NewsList(singleSource))
                    .toList()),
          )
        ],
      ),
    );
  }

  Widget buildTab(Source source, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.blue, width: 1)),
      child: Text(
        source.name ?? "",
        style: TextStyle(
            fontSize: 18, color: isSelected ? Colors.white : Colors.blue),
      ),
    );
  }
}
