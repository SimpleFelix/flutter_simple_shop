import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/utils.dart';
import '../../modals/user.dart';

final userModel = ChangeNotifierProvider((ref) => UserModel());

// 用户信息
class UserModel extends ChangeNotifier {
  User? _user;
  String? _token;

  User? get user=> _user;

  // 用户登录的方法处理
  Future<bool> login(String username, String password) async {
    return await utils.api.login(username, password,
        userHandle: loginSuccess,
        tokenHandle: tokenHandle,
        loginFail: utils.showMessage);
  }

  // 用户登录成功
  void loginSuccess(User user) {
    _user = user;
    notifyListeners();
  }

  // token处理
  void tokenHandle(String token) {
    _token = token;
    notifyListeners();
  }
}
