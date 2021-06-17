import 'dart:convert';

import 'package:dd_taoke_sdk/network/util.dart';
import 'package:flutter/material.dart';

import '../modals/user.dart';
import 'utils.dart';

abstract class ApiService {
  /// 登入
  /// 返回 :  true 表示成功
  Future<bool> login(String username, String password);

  // 接口访问失败返回
  void errorHandle(int? code, String? msg);
}

/// 接口
class Api extends ApiService {
  final request = DdTaokeUtil();

  @override
  Future<bool> login(String username, String password,
      {ValueChanged<String>? tokenHandle,
      ValueChanged<User>? userHandle,
      ValueChanged<String>? loginFail}) async {
    final result = await request
        .post('/api/login', data: {'username': username, 'password': password},
            error: (int? code, String? msg) {
      if (msg != null) {
        loginFail?.call(msg);
      }
    });
    if (result.isNotEmpty) {
      final _userMap = jsonDecode(result)['user']!;
      final _token = jsonDecode(result)['token']!;
      final user = User.fromJson(_userMap);
      tokenHandle?.call(_token);
      userHandle?.call(user);
      return true;
    }
    return false;
  }

  @override
  void errorHandle(int? code, String? msg) {
    if (msg != null) {
      print(msg);
      utils.showMessage(msg);
    }
  }
}
