import 'package:flutter/material.dart';
import 'package:news_mon_c9/model/category_dm.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/news/news_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryDM? currentCategory;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(currentCategory == null){
          return Future.value(true);
        }else {
          currentCategory = null;
          setState(() {});
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News app!"),
        ),
        body: currentCategory == null ? CategoriesTab(onCategoryClicked) :
        NewsTab(categoryId: currentCategory!.id),
      ),
    );
  }

  onCategoryClicked(CategoryDM clickedCategory){
    currentCategory = clickedCategory;
    setState(() {});
  }
}
