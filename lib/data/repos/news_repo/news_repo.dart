import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_mon_c9/data/model/sources_response.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/offline_data_source/offline_data_source.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/online_data_source/api_manager.dart';

class NewsRepo {
  OfflineDataSource offlineDataSource;
  ApiManager onlineDataSource;

  NewsRepo({required this.offlineDataSource, required this.onlineDataSource});

  Future<SourcesResponse?> getSources(String categoryId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi){
     SourcesResponse sourcesResponse = await onlineDataSource.getSources(categoryId);
     offlineDataSource.saveSources(categoryId, sourcesResponse);
     return sourcesResponse;
    }else {
      return offlineDataSource.getSources(categoryId);
    }
  }
}