import 'dart:convert';

import 'package:dd_taoke_sdk/network/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/app_controller.dart';
import '../modals/user.dart';
import 'utils.dart';

abstract class ApiService {
  /// 登入
  /// 返回 :  true 表示成功
  Future<bool> login(String username, String password);

  // 接口访问失败返回
  void errorHandle(int? code, String? msg);

  /// 获取用户相关信息
  Future<User?> getUser(String token);
}

/// 接口
class Api extends ApiService {
  final request = DdTaokeUtil();

  /// 登录接口
  /// 如果登入成功,服务器会返回jwt 鉴权token ,token一般30天内有效
  /// 可以通过token获取用户相关信息
  /// 函数返回bool类型,true表示成功
  @override
  Future<bool> login(String username, String password, {ValueChanged<String>? tokenHandle, ValueChanged<String>? loginFail}) async {
    final result = await request.post('/api/user/login', data: {'loginNumber': username, 'password': password}, error: (int? code, String? msg) {
      if (msg != null) {
        loginFail?.call(msg);
      }
    });
    if (result.isNotEmpty) {
      Get.log('登录成功:$result');
      tokenHandle?.call(result);
      return true;
    }
    return false;
  }

  @override
  Future<User?> getUser(String token) async {
    final result = await request.get('/api/auth/current', data: {'token': token},onStart: AppController.find.addAuthDetail,isTaokeApi: false);

    try{
      return User.fromJson(jsonDecode(result));
    }catch(e,s){
      print(e);
      print(s);
      return null;
    }
  }

  @override
  void errorHandle(int? code, String? msg) {
    if (msg != null) {
      print(msg);
      utils.showMessage(msg);
    }
  }
}
