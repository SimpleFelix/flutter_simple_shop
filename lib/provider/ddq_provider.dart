// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/ddq_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';

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
    final result = await DdTaokeSdk.instance.getDdq();
    if (result != null) {
      goodsList.addAll(result.goodsList ?? []);
      roundsList.addAll(result.roundsList ?? []);
    }
    notifyListeners();
  }

  Future<void> timeChange(DateTime? time, int? state) async {
    ddqTime = time;
    goodsList = [];
    status = state;
    dateTime = time.toString();
    await loadData();
  }
}
