// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../common/utils.dart';
import '../../modals/blog_category_model.dart';

final categoryRiverpod = ChangeNotifierProvider<CategoryState>((ref) => CategoryState());

class CategoryState extends ChangeNotifier {
  List<Category> categorys = [];

  late Category current;

  Category? currentWithProductList;

  Subcategory? currentSubCategory;

  List<BlogCategory> blogCategorys = [];

  Future<void> init() async {
    categorys.clear();
    final result = await DdTaokeSdk.instance.getCategorys();
    categorys.addAll(result);
    if (categorys.isNotEmpty) {
      setCurrent(result[0]);
    }
    notifyListeners();
  }

  void setCurrent(Category category) {
    current = category;
    notifyListeners();
  }

  void setCurrentWithProductList(Category category) {
    currentWithProductList = category;
    notifyListeners();
  }

  void setCurrentSubCategory(Subcategory subcategory) {
    currentSubCategory = subcategory;
    notifyListeners();
  }

  Future<List<BlogCategory>> getBlogCategory() async {
    final list = await utils.blogApi.getCategorys();
    blogCategorys = list;
    notifyListeners();
    return list;
  }

  int getIndexWithCategory(Category category){
   return categorys.indexWhere((element) => element.cid==category.cid);
  }
  Category getCategoryByIndex(int index){
    return categorys[index];
  }
}
