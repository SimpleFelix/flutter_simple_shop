// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './goods_item.dart';
import './sliver_app_bar_delegate.dart';
// Project imports:
import '../../common/utils.dart';
import '../../provider/ddq_provider.dart';
import '../../widgets/ddq_times_widget.dart';

/// 钉钉抢的页面
class DdqIndexHome extends StatefulWidget {
  @override
  _DdqIndexHomeState createState() => _DdqIndexHomeState();
}

class _DdqIndexHomeState extends State<DdqIndexHome> {
  late DdqProvider ddqProvider = context.watch<DdqProvider>();
  int? cur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: utils.widgetUtils.kBodyHeight + kToolbarHeight,
      width: Get.width,
      child: Stack(
        children: [
          _bg(),
          Positioned(
            top: kToolbarHeight + Get.mediaQuery.padding.top,
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomScrollView(
              slivers: <Widget>[
                _buildSliverAppBar(),
                _buildTimesList(),
                _buildList(),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                      maxHeight: 75,
                      minHeight:75,
                      child: Container(
                        child: Center(
                          child: Text('我是有底线的~~'),
                        ),
                      )),
                )
              ],
            ),
          ),
          _title(),
          _backBtn()
        ],
      ),
    ));
  }

  /// 仅仅显示一张背景图片
  Widget _renderBgImage() {
    return Image.asset('assets/images/ddq.png', fit: BoxFit.cover);
  }

  /// 标题
  Widget _title() {
    return Positioned(
        left: 0,
        top: 22+ Get.mediaQuery.padding.top,
        right: 0,
        child: Container(
            alignment: Alignment.center,
            child: Text(
              '钉钉抢',
              style: TextStyle(color: Colors.white, fontSize: 18),
            )));
  }

  /// 返回按钮
  Widget _backBtn() {
    return Positioned(
        left: 12,
        top: 12 + Get.mediaQuery.padding.top,
        child: BackButton(
          color: Colors.white,
        ));
  }

  /// 背景
  Widget _bg() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Image.asset(
          'assets/images/ddq.png',
          width: Get.width,
          height: 170 + kToolbarHeight,
          fit: BoxFit.cover,
        ));
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 170 ,
      elevation: 0,
      backgroundColor: Colors.transparent,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _renderBgImage(),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }

  /// 时间列表
  Widget _buildTimesList() {
    return SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: SliverAppBarDelegate(
            minHeight: 60,
            maxHeight: 60,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.white70))),
              child: DdqTimesWidget(
                timesList: ddqProvider.roundsList,
                ddqProvider: ddqProvider,
              ),
            )));
  }


  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return GoodsItem(
        goodsItem: ddqProvider.goodsList[index],
        state: ddqProvider.status,
      );
    }, childCount: ddqProvider.goodsList.length));
  }
}
