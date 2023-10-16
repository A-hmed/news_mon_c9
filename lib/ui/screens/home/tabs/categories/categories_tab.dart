import 'package:flutter/material.dart';
import 'package:news_mon_c9/model/category_dm.dart';
import 'package:news_mon_c9/ui/screens/home/tabs/categories/category_widget.dart';

class CategoriesTab extends StatelessWidget {
  Function(CategoryDM) onCategoryClick;
  CategoriesTab(this.onCategoryClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .08
      ),
      child: Column(
        children: [
          SizedBox(height: 12 ,),
          Text("Pick your category"),
          SizedBox(height: 24,),
          Expanded(
            child: GridView.builder(
                itemCount: CategoryDM.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      onCategoryClick(CategoryDM.categories[index]);
                    },
                    child: CategoryWidget(
                      categoryDM: CategoryDM.categories[index],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

}
