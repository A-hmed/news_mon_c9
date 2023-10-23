import 'package:flutter/material.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/offline_data_source/offline_data_source.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/online_data_source/api_manager.dart';
import 'package:news_mon_c9/data/model/sources_response.dart';
import 'package:news_mon_c9/data/repos/news_repo/news_repo.dart';

class NewsTabViewModel extends ChangeNotifier{
  List<Source> sources = [];
  bool isLoading = false;
  late TabController tabController;
  String? errorText;
  int currentTab = 0;
  OfflineDataSource offlineDataSource = OfflineDataSource();
  ApiManager onlineDataSource = ApiManager();
  late NewsRepo newsRepo;

  NewsTabViewModel(){
    newsRepo = NewsRepo(offlineDataSource: offlineDataSource,
        onlineDataSource: onlineDataSource);
  }


  getSources(String categoryId) async {
    isLoading = true;
    notifyListeners();

    try{
      SourcesResponse? sourcesResponse = await newsRepo.getSources(categoryId);
      if(sourcesResponse?.sources?.isNotEmpty == true){
        isLoading = false;
        sources = sourcesResponse!.sources!;
        notifyListeners();
      }else {
        throw Exception("Something went wrong please try again later");
      }
    }catch(e){
      isLoading = false;
      errorText = e.toString();
      notifyListeners();
    }
  }
}