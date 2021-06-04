import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> categorys = [];

  Future<void> loadDtkCategoryDatas(BuildContext context) async {
    final result = await DdTaokeSdk.instance.getCategorys();
    categorys.addAll(result);
    notifyListeners();
  }
}
