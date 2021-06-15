
import 'package:dd_taoke_sdk/network/util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// import 'package:window_size/window_size.dart';
import './app.dart';
import './fluro/application.dart';
import './fluro/routes.dart';
import './provider/providers.dart';
import 'common/service.dart';
import 'common/utils.dart';
import 'common/widget_util.dart';
import 'fluro/navigator_util.dart';

void main() async {
  /// 初始化sdk能力
  DdTaokeUtil.instance.init('http://itbug.shop', '80');
  var router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  WidgetsFlutterBinding.ensureInitialized();
  await Stetho.initialize();
  GetIt.instance.registerSingleton<Utils>(Utils());
  GetIt.instance.registerSingleton<WidgetUtils>(WidgetUtils());
  GetIt.instance.registerSingleton<NavigatorUtil>(NavigatorUtil());
  GetIt.instance.registerSingleton<Api>(Api());
  /// 构建web程序需要注释这个,会报错
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   setWindowTitle('典典的小卖部 桌面客户端  v2.0.0');
  // }
  runApp(MyApp());
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
        home: App(),
      ),
    );
  }
}



