import 'package:demo1/pages/panic_buying/components/list.dart';
import 'package:demo1/pages/zhe/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/simple_appbar.dart';
import '../panic_buying/components/categorys.dart';

class ZheIndex extends StatefulWidget {
  const ZheIndex({Key? key}) : super(key: key);

  @override
  _ZheIndexState createState() => _ZheIndexState();
}

class _ZheIndexState extends State<ZheIndex> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
      await context.read(zheRiverpod).fetchData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:SimpleAppBar(
        title: '折上折 - 拍两件更优惠',
        bottom: BottomCategoryTabs(
          onTap: context.read(zheRiverpod).onTabChange,
          insets: [
            Tab(text: '推荐',)
          ],
        ),
        bottomHeight: 48,
      ),

      body: EasyRefresh.custom(slivers: [
        Consumer(builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final list = watch(zheRiverpod).products;
          return ProductsList(list);
        },)

      ]),
    );
  }
}
