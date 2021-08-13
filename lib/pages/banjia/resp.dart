


// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/halfday_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final banjiaRiverpod = ChangeNotifierProvider((ref)=>BanjiaResp());

class BanjiaResp extends ChangeNotifier{


  List<ListElement> products = [];
  List<SessionsList> sessions = [];
  String? banner;

  String  currTime= '';

  bool loading = false;

  // 初始化
  Future<bool> init({bool change=false})async{


    loading = true;
    products.clear();
    if(!change){
      sessions.clear();
    }

    notifyListeners();

   final result =  await DdTaokeSdk.instance.getHalfdayProducts(sessions: currTime);

   if(result!=null){
     products.addAll(result.halfPriceInfo!.list??[]);
     if(!change){
       sessions.addAll(result.sessionsList??[]);
     }

     if(result.halfPriceInfo!.banner!=null){
       banner = result.halfPriceInfo!.banner;
     }
     if(!change){
       currTime = sessions.firstWhere((element) => element.status=='1').hpdTime??'';
     }


     loading = false;
     notifyListeners();
   }

    return false;
  }


  void onChange(String time){
    print('change $time');
    currTime = time;
    init(change: true);
  }

}
