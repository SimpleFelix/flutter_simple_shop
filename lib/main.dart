import 'dart:io';

import 'package:dd_taoke_sdk/network/util.dart';
import 'package:demo1/service/api_service.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import './fluro/application.dart';
import './fluro/routes.dart';
import './provider/providers.dart';
import 'ad.dart';
import 'common/service.dart';
import 'common/utils.dart';
import 'common/widget_util.dart';
import 'controller/app_controller.dart';
import 'fluro/navigator_util.dart';

void main() async {
  /// 初始化sdk
  DdTaokeUtil.instance.init('https://itbug.shop', '443'); //  远程服务器

  /// 路由配置
  /// [已弃用]
  var router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;

  /// 本地缓存工具类
  try{
    await SpUtil.getInstance();
  }catch(_){}

  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化单例工具类
  GetIt.instance.registerSingleton<Utils>(Utils());
  GetIt.instance.registerSingleton<WidgetUtils>(WidgetUtils());
  GetIt.instance.registerSingleton<NavigatorUtil>(NavigatorUtil());
  GetIt.instance.registerSingleton<Api>(Api());
  GetIt.instance.registerSingleton<TKApiService>(TKApiService());

  /// https 请求处理
  HttpOverrides.global = MyHttpOverrides();

  /// getx 控制器

  /// 构建web程序需要注释这个,会报错
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   setWindowTitle('典典的小卖部 桌面客户端  v2.0.0');
  // }

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
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(primaryColor: Colors.white, bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedLabelStyle: TextStyle(color: Colors.pink), selectedItemColor: Colors.pink)),
        onInit: () {
          Get.put(AppController());
        },
        home: AdPage(),
        navigatorObservers: [HeroController()],
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
