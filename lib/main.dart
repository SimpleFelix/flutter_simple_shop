// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dd_taoke_sdk/network/util.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

// Project imports:
import './provider/providers.dart';
import 'ad.dart';
import 'common/service.dart';
import 'common/utils.dart';
import 'common/widget_util.dart';
import 'controller/app_controller.dart';
import 'service/api_service.dart';
import 'service/blog_api.dart';
import 'service/user_api.dart';
import 'util/navigator_util.dart';

void main() async {

  /// 初始化典典小卖部的Api sdk 文档-->[https://pub.dev/packages/dd_taoke_sdk]

  DdTaokeUtil.instance.init('https://itbug.shop', '443', debug: false); //  远程服务器
  /// DdTaokeUtil.instance.init('https://192.168.199.64', '443', debug: false); // 本地测试服务器

  /// 使用浏览器查看网络请求,详情查看[https://www.jianshu.com/p/e4058e064341]
  /// await Stetho.initialize();

  /// 本地缓存工具类
  await Hive.initFlutter();
  await Hive.openBox('app');

  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化单例工具类
  GetIt.instance.registerSingleton<Utils>(Utils());
  GetIt.instance.registerSingleton<WidgetUtils>(WidgetUtils());
  GetIt.instance.registerSingleton<NavigatorUtil>(NavigatorUtil());
  GetIt.instance.registerSingleton<Api>(Api());
  GetIt.instance.registerSingleton<TKApiService>(TKApiService());
  GetIt.instance.registerSingleton<BlogApi>(BlogApi());
  GetIt.instance.registerSingleton<UserApi>(UserApi());

  /// https 请求处理
  HttpOverrides.global = MyHttpOverrides();


  /// windows 版本处理函数
  if (!GetPlatform.isWeb && (GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isMacOS)) {
    setWindowTitle('典典的小卖部 桌面客户端  v2.0.0');
    final windowSize = Size(500, 1041);
    setWindowMaxSize(windowSize);
    setWindowMinSize(windowSize);
  }

  /// 启动app
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '典典小卖部',
        theme: ThemeData(
            primaryColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Colors.pink, unselectedLabelStyle: TextStyle(fontSize: 12), selectedLabelStyle: TextStyle(fontSize: 12))),
        onInit: () {
          Get.put(AppController());
        },
        home: AdPage(),
      ),
    );
  }
}

/// 配置https整数问题
///
/// 相关文档: [https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req]
///
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
