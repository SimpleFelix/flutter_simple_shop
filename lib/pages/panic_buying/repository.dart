
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/top_param.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final panicBuyingRiverpod = ChangeNotifierProvider((ref)=>PanicBuyingModel());

//数据模型
class PanicBuyingModel extends ChangeNotifier {

  bool initLoading = false;

  List<Category> cates = [];
  List<Product> tops = []; // 排行前三
  List<Product> products = [];
  int _page = 1;

  /// 页面初始化
  Future<void> init() async {
    initLoading = true;
    notifyListeners();

    await _loadCategory();
    await loadRealTimeProduct();

    initLoading = false;
    notifyListeners();

  }

  // 加载实时榜单商品
  Future<void> loadRealTimeProduct()async {
   final result = await DdTaokeSdk.instance.getTopProducts(param: TopParam(rankType: '1', pageId: '$_page'));
   if(result.isNotEmpty){
     final _tops = result.sublist(0,3);
     tops.addAll(_tops);
     print(tops.length);
     result.removeRange(0, 3);
     products.addAll(result);
     notifyListeners();
   }
  }


  // 加载分类数据
  Future<void> _loadCategory() async {
    final _cates = await DdTaokeSdk.instance.getCategorys();
    cates.addAll(_cates);
  }

}