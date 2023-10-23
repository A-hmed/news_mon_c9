import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_mon_c9/data/model/sources_response.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/offline_data_source/offline_data_source.dart';
import 'package:news_mon_c9/data/repos/news_repo/data_sources/online_data_source/api_manager.dart';
import 'package:news_mon_c9/data/repos/news_repo/news_repo.dart';

class NewsTabViewModel extends Cubit {
  int currentTab = 0;
  OfflineDataSource offlineDataSource = OfflineDataSource();
  ApiManager onlineDataSource = ApiManager();
  late NewsRepo newsRepo;

  NewsTabViewModel() : super(NewsTabLoadingState()) {
    newsRepo = NewsRepo(
        offlineDataSource: offlineDataSource,
        onlineDataSource: onlineDataSource);
  }

  getSources(String categoryId) async {
    emit(NewsTabLoadingState());
    try {
      SourcesResponse? sourcesResponse = await newsRepo.getSources(categoryId);
      if (sourcesResponse?.sources?.isNotEmpty == true) {
        emit(NewsTabSuccessState(sourcesResponse!.sources!));
      } else {
        throw Exception("Something went wrong please try again later");
      }
    } catch (e) {
      emit(NewsTabErrorState(e.toString()));
    }
  }
}

class NewsTabLoadingState {}

class NewsTabSuccessState {
  List<Source> sources;

  NewsTabSuccessState(this.sources);
}

class NewsTabErrorState {
  String errorMessage;

  NewsTabErrorState(this.errorMessage);
}
