import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/ddq_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:flutter/material.dart';

// 钉钉抢状态管理
class DdqProvider extends ChangeNotifier {
  List<Product> goodsList = [];
  List<RoundsList> roundsList = [];
  DateTime? ddqTime;
  int? status;

  //时间段
  String dateTime = '';

  /// 加载数据
  Future<void> loadData() async {
    var data = dateTime == '' ? {} : {'roundTime': dateTime.substring(0, dateTime.length - 4)};
    final result = await DdTaokeSdk.instance.getDdq();
    if (result != null) {
      goodsList.addAll(result.goodsList ?? []);
      roundsList.addAll(result.roundsList ?? []);
    }
    notifyListeners();
  }

  Future<void> timeChange(DateTime? time, int? state) async {
    this.ddqTime = time;
    this.goodsList = [];
    this.status = state;
    this.dateTime = time.toString();
    this.loadData();
  }
}
