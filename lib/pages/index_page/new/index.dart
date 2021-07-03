import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'component/appbar.dart';
import 'component/carousel.dart';
import 'component/gridmenu/view.dart';

/// 新版首页
class IndexHomeNew extends StatelessWidget {
  const IndexHomeNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndexHomeAppbar(),
      body: EasyRefresh.custom(slivers: [SliverPadding(padding: EdgeInsets.only(top: 12), sliver: IndexCarousel()), GridMenuComponent()]),
    );
  }
}
