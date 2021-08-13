// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/super_search_param.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchRiverpod = ChangeNotifierProvider((ref) => SearchState()); // 用户搜索的关键字

class SearchState extends ChangeNotifier {
  String type = '0';
  int page = 1;
  int pageSize = 20;
  String searchKeyWorlds = '';
  bool initLoading = false;

  List<Product> products = []; // 产品列表

  // 加载数据
  // 初始化
  Future<void> loadData({String? worlds}) async {
    if (worlds != null) {
      searchKeyWorlds = worlds;
      products.clear();
      page = 1;
      initLoading = true;
      notifyListeners();
    }
    final result = await DdTaokeSdk.instance.superSearch(param: SuperSearchParam(keyWords: searchKeyWorlds, pageSize: '$pageSize', type: '$type', pageId: '$page'));
    if (result != null) {
      products.addAll(result.list ?? []);
      page++;
      initLoading = false;
      notifyListeners();
    }
  }

  /// 加载下一页
  Future<void> nextPage() async {
    final result = await DdTaokeSdk.instance.superSearch(param: SuperSearchParam(keyWords: searchKeyWorlds, pageSize: '$pageSize', type: '$type', pageId: '$page'));
    if(result!=null){
      products.addAll(result.list??[]);
      page++;
      notifyListeners();
    }
  }
}
