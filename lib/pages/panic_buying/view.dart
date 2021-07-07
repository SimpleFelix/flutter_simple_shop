import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/simple_appbar.dart';
import 'components/categorys.dart';
import 'components/list.dart';
import 'components/view_status.dart';
import 'repository.dart';

///
/// @Author 梁典典
/// @Github 开源地址 https://github.com/mdddj/flutter_simple_shop
/// @Description 功能描述  排行榜页面
/// @Date 创建时间 2021年6月19日 14:38:39
///
class PanicBuyingPage extends StatefulWidget {
  const PanicBuyingPage({Key? key}) : super(key: key);

  @override
  _PanicBuyingPageState createState() => _PanicBuyingPageState();
}

class _PanicBuyingPageState extends State<PanicBuyingPage> {
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read(panicBuyingRiverpod).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: '排行榜单',
        bottom: BottomCategoryTabs(
          insets: [
            Tab(
              text: '实时榜',
            ),
            Tab(
              text: '全天榜',
            ),
          ],
          onTap:  context.read(panicBuyingRiverpod).tabChanged,
        ),
        bottomHeight: 48,
      ),
      body: Stack(
        children: [
          EasyRefresh.custom(
            controller: easyRefreshController,
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 12)),
              SliverToBoxAdapter(
                child: ViewStatusWithPanicBuy(),
              ),
              Consumer(builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
                return ProductsList(watch(panicBuyingRiverpod).products);
              },)
            ],
            onLoad: () async {
              final result = await context.read(panicBuyingRiverpod).nextPage();
              easyRefreshController.finishLoad(noMore: result);
            },
            footer: MaterialFooter(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    easyRefreshController.dispose();
  }
}

void toPanicBuyPage() => Get.to(() => PanicBuyingPage());
