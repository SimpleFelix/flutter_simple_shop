import 'package:demo1/pages/index_page/new/waimai/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';

///
/// @Author 梁典典
/// @Github 开源地址 https://github.com/mdddj/flutter_simple_shop
/// @Description 功能描述 领取外卖活动首页
/// @Date 创建时间 2021年7月2日 11:46:22
///
class WaimaiIndex extends StatelessWidget {
  const WaimaiIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MorphingAppBar(
        title: Text(
          '外卖红包',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return EasyRefresh.custom(slivers: [renderWaimaihongbao(), renderWaimaiShangChao()]);
  }

  /// 商超红包
  Widget renderWaimaiShangChao() {
    return SliverToBoxAdapter(
      child: GestureDetector(
          onTap: ()=>navTo('2'),
          child: renderImage('assets/images/waimai2.png')),
    );
  }

  /// 普通外卖红包
  Widget renderWaimaihongbao() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: ()=> navTo('1'),
          child: renderImage('assets/images/waimai1.png')),
    );
  }

  void navTo(String type){
    Get.context!.navigator.push(SwipeablePageRoute(builder: (_)=>WaimaiDetail(type: type)));
  }

  /// 渲染图片
  Widget renderImage(String image) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1.75,
        child: Image.asset(image),
      ),
    );
  }
}
