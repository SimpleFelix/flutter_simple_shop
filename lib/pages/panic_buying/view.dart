import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/simple_appbar.dart';
import 'components/categorys.dart';
import 'components/list.dart';
import 'components/tops_list.dart';
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
        bottom: CategorysWithPanicBuying(
          insets: [
            Tab(
              text: '实时榜',
            ),
            Tab(
              text: '全天榜',
            ),
          ],
        ),
        bottomHeight: 48,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ViewStatusWithPanicBuy(),
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
