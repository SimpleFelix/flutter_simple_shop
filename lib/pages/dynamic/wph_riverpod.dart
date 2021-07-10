

import '../../service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final wphRiverpod = ChangeNotifierProvider((ref)=> WphState());


/// 唯品会
class WphState extends ChangeNotifier {

  List<dynamic> products = [];

  int page = 1;


  Future<void> init() async {
    await tkApi.getWphJbProducts(page,valueChanged: (list){
      products.addAll(list);
    });
    notifyListeners();
  }


  // 下一页
  Future<void> nextPage() async {
    page ++ ;
    await init();
  }

}