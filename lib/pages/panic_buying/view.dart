import 'package:demo1/pages/panic_buying/components/appbar.dart';
import 'package:demo1/pages/panic_buying/components/daojishi.dart';
import 'package:demo1/pages/panic_buying/components/tops_list.dart';
import 'package:demo1/pages/panic_buying/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'components/categorys.dart';
import 'components/list.dart';

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
      body: Stack(
        children: [
          Image.asset('assets/images/top_bg.png'),
          CustomScrollView(
            slivers: [
              AppbarWithPanicBuying(),
              SliverToBoxAdapter(
                child: CategorysWithPanicBuying(
                  insets: [
                    Tab(
                      text: '实时榜',
                    ),
                    Tab(
                      text: '全天榜',
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: DaojishiComp(),
              ),
              TopsProducts(),
              ProductListWithPanic()
            ],
          ),
        ],
      ),
    );
  }
}

void toPanicBuyPage() => Get.to(() => PanicBuyingPage());
