import 'dart:convert';

import 'package:dd_taoke_sdk/network/util.dart';
import 'package:http/http.dart' as http;

import 'utils.dart';

abstract class ApiService {
  // 登入
  Future<void> login(String username, String password);

  // 接口访问失败返回
  void errorHandle(int? code, String? msg);
}

/// 接口
class Api extends ApiService {
  final request = DdTaokeUtil();

  @override
  Future<void> login(String username, String password) async {
   final result = await request.post('/api/login',data: {
     'username':username,
     'password':password
   },error: errorHandle);
   print(result);

  }

  @override
  void errorHandle(int? code, String? msg) {
    if (msg != null) {
      print(msg);
      utils.showMessage(msg);
    }
  }
}
