

import 'dart:convert';

import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/halfday_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final banjiaRiverpod = ChangeNotifierProvider((ref)=>BanjiaResp());

class BanjiaResp extends ChangeNotifier{


  List<ListElement> products = [];
  List<SessionsList> sessions = [];
  String? banner;

  // 初始化
  Future<bool> init()async{


   final result =  await DdTaokeSdk.instance.getHalfdayProducts();

   if(result!=null){
     products.addAll(result.halfPriceInfo!.list??[]);
     sessions.addAll(result.sessionsList??[]);
     if(result.halfPriceInfo!.banner!=null){
       banner = result.halfPriceInfo!.banner;
     }

     notifyListeners();
   }

    return false;
  }

}