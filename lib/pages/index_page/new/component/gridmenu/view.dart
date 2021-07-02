import 'package:demo1/pages/index_page/new/waimai/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../../index_riverpod.dart';
import 'menu_item.dart';
import 'model.dart';

const elmImage = 'assets/svg/elm_logo.svg';

final gridMenuModles = [GridMenuItem(item: GridMenuModel(title: '饿了么领券', image: elmImage, isAssets: true, onTap: () {
  Get.context!.navigator.push(SwipeablePageRoute(builder: (_)=>WaimaiIndex()));
}))];

/// 首页的网格菜单
class GridMenuComponent extends StatelessWidget {
  const GridMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverWaterfallFlow.count(
      crossAxisCount: 4,
      children: gridMenuModles,
    );
  }
}
