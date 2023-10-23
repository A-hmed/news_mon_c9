import 'package:flutter/material.dart';
import 'package:news_mon_c9/data/model/sources_response.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/news/news_list.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/news/news_tab_view_model.dart';
import 'package:news_mon_c9/ui/widgets/error_widget.dart' as e;
import 'package:news_mon_c9/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatefulWidget {
  String categoryId;

  NewsTab({required this.categoryId});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with TickerProviderStateMixin {
  late NewsTabViewModel viewModel = NewsTabViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.categoryId);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return viewModel;
      },
      child: Consumer<NewsTabViewModel>(
        builder: (_, pro, ___) {
          return viewModel.isLoading
              ? const LoadingWidget()
              : viewModel.errorText != null
                  ? e.ErrorWidget(message: viewModel.errorText!)
                  : buildTabs(viewModel.sources);
        },
      ),
    );
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
                viewModel.currentTab = index;
                setState(() {});
              },
              indicatorColor: Colors.transparent,
              isScrollable: true,
              tabs: sources
                  .map((singleSource) => buildTab(singleSource,
                      sources.indexOf(singleSource) == viewModel.currentTab))
                  .toList()),
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
