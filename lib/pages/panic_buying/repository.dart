
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final panicBuyingRiverpod = ChangeNotifierProvider((ref)=>PanicBuyingModel());

//数据模型
class PanicBuyingModel extends ChangeNotifier {

  bool initLoading = false;

  List<Category> cates = [];

  /// 页面初始化
  Future<void> init() async {
    initLoading = true;
    notifyListeners();

    await _loadCategory();

    initLoading = false;
    notifyListeners();

  }

  // 加载分类数据
  Future<void> _loadCategory() async {
    final _cates = await DdTaokeSdk.instance.getCategorys();
    cates.addAll(_cates);
  }

}