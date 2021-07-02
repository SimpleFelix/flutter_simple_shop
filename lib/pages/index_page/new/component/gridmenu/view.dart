import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../../panic_buying/view.dart';
import '../../waimai/index.dart';
import 'menu_item.dart';
import 'model.dart';

const elmImage = 'assets/svg/elm_logo.svg';
const phbImage = 'assets/svg/phb.svg';

final gridMenuModles = [
  /// 领券
  GridMenuItem(
      item: GridMenuModel(
          title: '饿了么领券',
          image: elmImage,
          isAssets: true,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => WaimaiIndex()));
          })),

  /// 排行榜
  GridMenuItem(
      item: GridMenuModel(
          title: '排行榜',
          image: phbImage,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => PanicBuyingPage()));
          },
          isAssets: true))
];

/// 首页的网格菜单
class GridMenuComponent extends StatelessWidget {
  const GridMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: WaterfallFlow.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridMenuModles,
      ),
    );
  }
}
