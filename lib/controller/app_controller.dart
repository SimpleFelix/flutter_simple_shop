import 'dart:convert';
import 'dart:typed_data';

import 'package:demo1/service/api_service.dart';
import 'package:demo1/widgets/component/new_version_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

import '../network/interceptor/auth_interceptor.dart';
import '../provider/riverpod/user_riverpod.dart';

/// app 控制器
class AppController extends GetxController {
  static AppController get find => Get.find<AppController>();

  Rxn bgBytes = Rxn<Uint8List>();

  @override
  void onInit() {
    adStart();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Get.context!.read(userModel).appStartWithUserModel();
  }

  /// 请求中添加授权信息
  void addAuthDetail(Dio dio) {
    dio.interceptors.add(AuthInterceptor());
  }

  /// 加载启动图到内存中
  void adStart() async {
    final bytes = await rootBundle.load('assets/images/ad.png');
    final list = bytes.buffer.asUint8List();
    bgBytes.value = list;
    update();
  }

  /// 检测新版本
  Future<void> getNewVersion() async {
    if (!kIsWeb) {
      final serverVersion = await tkApi.getLastVersion();
      if (serverVersion.isNotEmpty) {
        final map = jsonDecode(serverVersion);
        if(GetPlatform.isAndroid){
          final packInfo = await PackageInfo.fromPlatform();
          if (map['version'] != packInfo.version) {
            // 判定为有新版本
            await Get.dialog(NewVersionDialog(map: map));
          }
        }
      }
    }
  }
}
