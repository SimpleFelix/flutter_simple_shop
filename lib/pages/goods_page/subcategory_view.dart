import 'package:dd_taoke_sdk/model/category.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/riverpod/category_riverpod.dart';

class SubCategoryView extends ConsumerWidget {
  final ValueChanged<Subcategory>? changeSubcategory;

  SubCategoryView({this.changeSubcategory});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final current = watch(categoryRiverpod).currentWithProductList;
    if (current != null) {
      final showSubcategorys = current.subcategories;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 0.8),
        itemCount: showSubcategorys!.length > 10 ? 10 : showSubcategorys.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return buildSubCategoryItem(showSubcategorys[index]);
        },
      );
    }
    return Container();
  }

  // 子分类布局
  Widget buildSubCategoryItem(Subcategory subcategory) {
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        final currentSubCategory = watch(categoryRiverpod).currentSubCategory;
        return InkWell(
          onTap: () {
            if (currentSubCategory != null &&
                subcategory.subcid != currentSubCategory.subcid) {
              changeSubcategory?.call(subcategory);
            }
          },
          child: Container(
            width: 200.w,
            child: Column(
              children: <Widget>[
                ExtendedImage.network(
                  subcategory.scpic!,
                  width: ScreenUtil().setWidth(200),
                  fit: BoxFit.fill,
                  cache: true,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                Text(
                  subcategory.subcname!,
                  style: TextStyle(
                      color: currentSubCategory != null &&
                              currentSubCategory.subcid == subcategory.subcid
                          ? Colors.pinkAccent
                          : Colors.black),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
