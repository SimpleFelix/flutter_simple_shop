
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final indexRiverpod = ChangeNotifierProvider<IndexState>((ref)=>IndexState());

/// 首页状态
class IndexState extends ChangeNotifier{

  bool indexLoading = false;


  /// 改变首页loading状态
  void changeLoadingState(bool value){
    indexLoading = value;
    print('index loading changed value: $value');
    notifyListeners();
  }


}