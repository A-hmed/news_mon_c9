import 'package:flutter/material.dart';
import 'package:news_mon_c9/api_manager/api_manager.dart';
import 'package:news_mon_c9/model/sources_response.dart';

class NewsTabViewModel extends ChangeNotifier{
  List<Source> sources = [];
  bool isLoading = false;
  late TabController tabController;
  String? errorText;
  int currentTab = 0;

  getSources(String categoryId) async {
    isLoading = true;
    notifyListeners();
    try{
      sources = await ApiManager.getSources(categoryId);
      isLoading = false;
      notifyListeners();
    }catch(e){
      isLoading = false;
      errorText = e.toString();
      notifyListeners();
    }
  }
}