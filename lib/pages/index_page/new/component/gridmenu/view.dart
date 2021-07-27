import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:demo1/common/utils.dart';
import 'package:demo1/config/app_config.dart';
import 'package:demo1/pages/brand_page/index.dart';
import 'package:demo1/pages/index_page/new/index_riverpod.dart';
import 'package:demo1/pages/jd/recommend/view.dart';
import 'package:demo1/pages/pinduoduo/search/view.dart';
import 'package:demo1/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
const mtwmImage = 'assets/svg/mt.svg';
const chf = 'assets/svg/chf.svg'; // 充话费
const pp = 'assets/svg/pp.svg'; // 品牌
const jd = 'assets/svg/jd.svg'; // 京东

final gridMenuModles = [
  /// 领券
  GridMenuItem(
      item: GridMenuModel(
          title: '饿了吗',
          image: elmImage,
          isAssets: true,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => WaimaiIndex()));
          })),

  GridMenuItem(
      item: GridMenuModel(
          title: '美团领券',
          image: mtwmImage,
          onTap: () async {
            Get.context!.read(indexRiverpod).changeLoadingState(true);
            await tkApi.meituan({'actId': '2', 'linkType': '1'}, mapHandle: (data) async {
              final url = (data['data'] ?? '').toString();
              print('美团推广链接:$url');
              if (url.isNotEmpty) {
                await utils.openLink(url);
              }
            });
            Get.context!.read(indexRiverpod).changeLoadingState(false);
          },
          isAssets: true,
          onLongTap: () async {
            // 长按复制领取链接
            Get.context!.read(indexRiverpod).changeLoadingState(true);
            await tkApi.meituan({'actId': '2', 'linkType': '1'}, mapHandle: (data) async {
              final url = (data['data'] ?? '').toString();
              print('美团推广链接:$url');
              if (url.isNotEmpty) {
                utils.copy(url,message: '领券链接复制成功,打开浏览器粘贴即可');
                await utils.widgetUtils.showSimpleDialog('领券链接复制成功,打开浏览器粘贴即可',title: '获取链接成功');
              }
            });
            Get.context!.read(indexRiverpod).changeLoadingState(false);
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
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => ZheIndex(), canOnlySwipeFromEdge: true));
          },
          isAssets: true)),

  GridMenuItem(
      item: GridMenuModel(
          title: '每日半价',
          image: banjiaImage,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => BanjiaIndex(), canOnlySwipeFromEdge: true));
          },
          isAssets: true)),

  GridMenuItem(
      item: GridMenuModel(
          title: '拼夕夕',
          image: 'assets/svg/pdd.svg',
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => SearchPage(), canOnlySwipeFromEdge: true));
          },
          isAssets: true)),
  GridMenuItem(
      item: GridMenuModel(
          title: '8折话费',
          image: chf,
          onTap: () {
            utils.openLink(appConfig['huafeiUrl'].toString());
          },
          isAssets: true)),

  GridMenuItem(
      item: GridMenuModel(
          title: '精选品牌',
          image: pp,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => BrandListPage(), canOnlySwipeFromEdge: true));
          },
          isAssets: true)),

  GridMenuItem(
      item: GridMenuModel(
          title: '京东好货',
          image: jd,
          onTap: () {
            Get.context!.navigator.push(SwipeablePageRoute(builder: (_) => RecommendPage(), canOnlySwipeFromEdge: true));
          },
          isAssets: true)),
];

/// 首页的网格菜单
class GridMenuComponent extends StatelessWidget {
  const GridMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: WaterfallFlow.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: gridMenuModles,
        ),
      ),
    );
  }
}
