
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryRiverpod = ChangeNotifierProvider<CategoryState>((ref)=>CategoryState());

class CategoryState extends ChangeNotifier{

  List<Category> categorys = [];

  late Category current;

  Category? currentWithProductList;

  Subcategory? currentSubCategory;

  Future<void> init()async {
    categorys.clear();
   final result = await DdTaokeSdk.instance.getCategorys();
   categorys.addAll(result);
   if(categorys.isNotEmpty){
     setCurrent(result[0]);
   }
   notifyListeners();
  }


  void setCurrent(Category category){
    current = category;
    notifyListeners();
  }

  void setCurrentWithProductList(Category category){
    currentWithProductList = category;
    notifyListeners();
  }

  void setCurrentSubCategory(Subcategory subcategory){
    currentSubCategory = subcategory;
    notifyListeners();
  }

}