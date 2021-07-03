import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../../banjia/view.dart';
import '../../../../panic_buying/view.dart';
import '../../../../zhe/view.dart';
import '../../waimai/index.dart';
import 'menu_item.dart';
import 'model.dart';

const elmImage = 'assets/svg/elm_logo.svg';
const phbImage = 'assets/svg/phb.svg';
const zheImage = 'assets/svg/zhe.svg';
const banjiaImage = 'assets/svg/banjia.svg';

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
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => PanicBuyingPage(), canOnlySwipeFromEdge: true));
          },
          isAssets: true)),

  /// 折上折
  GridMenuItem(
      item: GridMenuModel(
          title: '折上折',
          image: zheImage,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_)=>ZheIndex(),canOnlySwipeFromEdge: true));
          },
          isAssets: true)),

  GridMenuItem(
      item: GridMenuModel(
          title: '每日半价',
          image: banjiaImage,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_)=>BanjiaIndex(),canOnlySwipeFromEdge: true));
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
