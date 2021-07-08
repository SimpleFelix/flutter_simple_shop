import 'package:after_layout/after_layout.dart';
import 'package:demo1/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/edit_page_handle.dart';
import 'component/appbar.dart';
import 'component/carousel.dart';
import 'component/gridmenu/view.dart';
import 'component/products.dart';
import 'index_riverpod.dart';

/// 新版首页
class IndexHomeNew extends StatefulWidget {
  const IndexHomeNew({Key? key}) : super(key: key);

  @override
  _IndexHomeNewState createState() => _IndexHomeNewState();
}

class _IndexHomeNewState extends State<IndexHomeNew> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return EditePageHandle(
      child: Scaffold(
        appBar: IndexHomeAppbar(),
        body: EasyRefresh.custom(
          slivers: [
            SliverPadding(padding: EdgeInsets.only(top: 12), sliver: IndexCarousel()),
            GridMenuComponent(),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  '典典精挑细选',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverPadding(
              sliver: IndexProductss(),
              padding: EdgeInsets.all(4),
            )
          ],
          onLoad: () async {
            await context.read(indexRiverpod).nextPage();
          },
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    AppController.find.getNewVersion();
  }
}
