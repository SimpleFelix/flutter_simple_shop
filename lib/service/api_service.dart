import 'dart:convert';

import 'package:dd_taoke_sdk/network/util.dart';
import 'package:demo1/pages/dynamic/model/wph_detail_resul.dart';
import 'package:demo1/pages/pinduoduo/search/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../common/toast.dart';
import '../common/utils.dart';

class TKApiService {
  /// 美团领券
  Future<String> meituan(Map<String, String> data, {ResultDataMapHandle? mapHandle}) async {
    final result = await utils.api.get('/api/zhe/mt/tg', data: data, mapHandle: mapHandle, error: (int? code, String? message) {
      if (message != null) {
        showToast(message);
      }
    });
    return result;
  }

  /// 设置最新版本号
  /// 需要登录
  /// 需要有admin权限
  Future<void> setNewVersionNumber(String number, String desc, String url) async {
    final result = await utils.api.post('/api/admin/set-last-version', {'version': number, 'desc': desc, 'url': url});
    utils.showMessage(result);
  }

  /// 获取服务器最新的版本号
  Future<String> getLastVersion() async {
    return await utils.api.get('/api/version/last-version');
  }

  /// 返回唯品会精编商品
  Future<void> getWphJbProducts(int page, {String? pageSize, String? sort, String? totalCount, ValueChanged<List<dynamic>>? valueChanged}) async {
    var data = <String, dynamic>{};
    data['page'] = '$page';
    if (pageSize != null) {
      data['pageSize'] = pageSize;
    }
    if (sort != null) {
      data['sort'] = sort;
    }
    if (totalCount != null) {
      data['totalCount'] = totalCount;
    }
    final result = await utils.api.get('/api/zhe/jb', data: data);
    try {
      final map = jsonDecode(result);
      if (map['status'] == 200) {
        final list = map['content'] as List<dynamic>;
        valueChanged?.call(list);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  /// 获取唯品会商品详情
  /// id  --  id 或者url
  Future<WeipinhuiDetail?> getWphProductInfo(String id) async {
    print('商品id: $id');
    final result = await utils.api.get('/api/zhe/info', data: {'id': id});
    if (result.isNotEmpty) {
      try {
        return WeipinhuiDetail.fromJson(jsonDecode(result));
      } catch (_) {}
    }
    return null;
  }

  /// 拼多多搜索
  Future<List<PddDetail>> pddSearch(String keyWorlds, {Map<String, dynamic>? map}) async {
    var result = <PddDetail>[];

    var data = <String, dynamic>{};
    data['keyword'] = keyWorlds;
    if (map != null) {
      data.addAll(map);
    }
    final response = await utils.api.get('/tkapi/api/v1/dtk/apis/pdd-search', data: data);

    if (response.isNotEmpty) {
      try {
        final _map = jsonDecode(response);
        print(_map['goodsList'].runtimeType);
        if (_map['goodsList'] is List<dynamic>) {
          final _list = List<PddDetail>.from((_map['goodsList'] as List<dynamic>).map((e) => PddDetail.fromJson(e))).toList();
          result.addAll(_list);
        }
      } catch (s, st) {
        print('解析拼多多数据失败:$s');
        print(st);
      }
    }
    return result;
  }

  /// 拼多多转链
  Future<void> pddCovert(String goodsSgin) async {
    var data = {'goodsSign': goodsSgin,'customParameters':'{"uid":"9246632808"}'};
    final result = await utils.api.get('/tkapi/api/v1/dtk/apis/pdd-goods-prom-generate', data: data);
    if (result.isNotEmpty) {
      Get.log(result);
    }
  }
}

TKApiService get tkApi => GetIt.I.get<TKApiService>();
