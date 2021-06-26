import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sp_util/sp_util.dart';

import '../../common/utils.dart';
import '../../modals/user.dart';

final userModel = ChangeNotifierProvider((ref) => UserModel());

// 用户信息
class UserModel extends ChangeNotifier {
  User? user;
  String? _token;

  /// 是否已经登录
  bool isLogin = false;


  // 用户登录的方法处理
  Future<bool> login(String username, String password) async {
    return await utils.api.login(username, password, tokenHandle: tokenHandle, loginFail: utils.showMessage);
  }

  // token处理
  void tokenHandle(String token) {
    _token = token;
    SpUtil.putString('token', token);
    appStartWithUserModel();
    notifyListeners();
  }

  // app启动的时候获取token,判断是否失败,
  Future<void> appStartWithUserModel() async {
    final token = SpUtil.getString('token');
    print('获取到本地存储的用户token:$token');
    if (token != null) {
     final _user = await utils.api.getUser(token);
     if(_user!=null){
       print('登录成功:${_user.nickName}');
       user = _user;
       _token = _token;
       isLogin = true;
       notifyListeners();
     }
    }
  }
}
