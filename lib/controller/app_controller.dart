
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../network/interceptor/auth_interceptor.dart';
import '../provider/riverpod/user_riverpod.dart';

/// app 控制器
class AppController extends GetxController {

  static AppController get find => Get.find<AppController>();

  @override
  void onReady() {
    super.onReady();
    Get.context!.read(userModel).appStartWithUserModel();
  }

  /// 请求中添加授权信息
  void addAuthDetail(Dio dio){
    dio.interceptors.add(AuthInterceptor());
  }

}