import 'package:flutter/material.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import './app.dart';
import './provider/providers.dart';
import 'package:fluro/fluro.dart';
import './fluro/Application.dart';
import './fluro/Routes.dart';
// 路由配置-----end

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
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
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: '典典小卖部',
          //自定义主题
          // 声明路由
          onGenerateRoute: Application.router.generator,
          home: App(),
        ),
      ),
    );
  }
}



