import 'dart:io';

import 'package:dd_taoke_sdk/network/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import './app.dart';
import './provider/providers.dart';
import 'package:fluro/fluro.dart';
import './fluro/Application.dart';
import './fluro/Routes.dart';

void main() {
  /// 初始化sdk能力
  DdTaokeUtil.instance.init('http://itbug.shop', '80');
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('典典的小卖部 桌面客户端  v2.0.0');
  }
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



