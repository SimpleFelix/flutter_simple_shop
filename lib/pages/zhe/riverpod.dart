


import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/discount_two_param.dart';
import 'package:demo1/provider/riverpod/category_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final zheRiverpod = ChangeNotifierProvider((ref)=>ZheState());

class ZheState extends ChangeNotifier{

  int _page = 1;
  int _pageSize = 20;
  String cid = '';

  bool loading = true;

  List<Product> products= [];

  /// 加载商品
  Future<void> fetchData() async {
   final result = await DdTaokeSdk.instance.getDiscountTwoProduct(param: DiscountTwoParam(pageSize: '$_pageSize', sort: '2', pageId: '$_page',cids: '$cid'));
   if(result!=null){
     products.addAll(result.list??[]);
   }
   loading = false;
   notifyListeners();
  }


  void onTabChange(int index){

    final categorys = Get.context!.read(categoryRiverpod).categorys;
    if(index==0){
      cid = '';
    }else{
      cid = '${categorys[index-1].cid}';
    }

    products.clear();
    loading = true;
    notifyListeners();

    fetchData();
  }


}