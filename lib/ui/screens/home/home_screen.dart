import 'package:flutter/material.dart';
import 'package:news_mon_c9/model/category_dm.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/news/news_tab.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/settings/settings.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentWidget ;
  late Widget categoriesTab;
  @override
  void initState() {
    super.initState();
    categoriesTab = CategoriesTab(onCategoryClicked);
    currentWidget = categoriesTab;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(currentWidget != categoriesTab){
          currentWidget = CategoriesTab(onCategoryClicked);
          setState(() {});
          return false;
        }else {
         return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News app!"),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(22))),
        ),
        body: currentWidget,
        drawer:  Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(child: Text("News app")),
              ),
              buildDrawerRow(Icons.list, "Categories", (){
                currentWidget = categoriesTab;
                Navigator.pop(context);
                setState(() {});
              }),
              buildDrawerRow(Icons.settings, "Settings", (){
                currentWidget = SettingsTab();
                Navigator.pop(context);
                setState(() {});
              })
            ],
          ),
        ),
      ),
    );
  }

  onCategoryClicked(CategoryDM clickedCategory){
    currentWidget = NewsTab(categoryId: clickedCategory.id);
    setState(() {});
  }

  buildDrawerRow(IconData iconData, String title, Function onClick){
    return InkWell(
      onTap: (){
        onClick();
      },
      child: Row(
        children: [
          SizedBox(width: 8,),
          Icon(iconData),
          SizedBox(width: 4,),
          Text(title),
        ],
      ),
    );
  }
}
