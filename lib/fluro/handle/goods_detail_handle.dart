
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/detail_page/index_home.dart';

Handler goodsDetailHandle = Handler(
  handlerFunc: (BuildContext? context,Map<String,List<String>> params){
    var goodsId = params['goods_id']?.first;
    return DetailIndex(goodsId:goodsId!);
  }
);