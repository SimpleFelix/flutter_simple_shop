import 'dart:convert';

import 'package:dd_taoke_sdk/network/util.dart';
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
  Future<void> setNewVersionNumber(String number,String desc,String url) async {
    final result = await utils.api.post('/api/admin/set-last-version', {'version': number,'desc':desc,'url':url});
    utils.showMessage(result);
  }

  /// 获取服务器最新的版本号
  Future<String> getLastVersion() async {
    return await utils.api.get('/api/version/last-version');
  }

  /// 返回唯品会精编商品
  Future<void> getWphJbProducts(int page,{String? pageSize,String? sort,String? totalCount,ValueChanged<List<dynamic>>? valueChanged}) async {
    var data = <String, dynamic>{};
    data['page'] = '$page';
    if(pageSize!=null) {
      data['pageSize'] = pageSize;
    }
    if(sort!=null){
      data['sort'] = sort;
    }
    if(totalCount!=null){
      data['totalCount'] = totalCount;
    }
    final result = await utils.api.get('/api/zhe/jb',data: data);
    try{
      final map = jsonDecode(result);
      if(map['status'] == 200){
        final list = map['content'] as List<dynamic>;
        valueChanged?.call(list);
      }
    }catch(e,s){
      print(e);
      print(s);
    }
  }

  /// 获取唯品会商品详情
  /// id  --  id 或者url
  Future<void> getWphProductInfo(String id) async {
    print('商品id: $id');
    final result = await utils.api.get('/api/zhe/info',data: {
      'id':id
    });
    Get.log(result);
  }
}

TKApiService get tkApi => GetIt.I.get<TKApiService>();
