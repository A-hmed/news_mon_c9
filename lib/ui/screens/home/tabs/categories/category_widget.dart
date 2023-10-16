import 'package:flutter/material.dart';
import 'package:news_mon_c9/model/category_dm.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryDM categoryDM;
  const CategoryWidget({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: categoryDM.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: categoryDM.isLeftSided ? Radius.zero : Radius.circular(24),
          bottomRight: !categoryDM.isLeftSided ? Radius.zero : Radius.circular(24)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * .16,
              child: Image.asset(categoryDM.imagePath)),
          Text(categoryDM.title, style: TextStyle(color: Colors.white),),
          SizedBox(height: 4,),
        ],
      ),
    );
  }
}
