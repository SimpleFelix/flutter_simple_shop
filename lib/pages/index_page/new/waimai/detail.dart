import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/activity-link_result.dart';
import 'package:dd_taoke_sdk/params/activity_link_param.dart';
import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../../common/utils.dart';
import '../../../../common/widgets/loading_mixin.dart';

///
/// @Author 梁典典
/// @Github 开源地址 https://github.com/mdddj/flutter_simple_shop
/// @Description 功能描述 外卖领取页面
/// @Date 创建时间  2021年7月2日 12:32:16
///
class WaimaiDetail extends StatefulWidget {
  final String type; // 类型 1 - 外卖红包  2 - 商超红包
  const WaimaiDetail({Key? key, required this.type}) : super(key: key);

  @override
  _WaimaiDetailState createState() => _WaimaiDetailState();
}

class _WaimaiDetailState extends State<WaimaiDetail> with LoadingMixin {
  ActivityLinkResult? model;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      setLoading(true);
      final result = await DdTaokeSdk.instance.getActivityLink(ActivityLinkParam(promotionSceneId: widget.type == '1' ? '20150318019998877' : '1585018034441'));
      if (mounted && result != null) {
        setState(() {
          model = result;
        });
      }
      setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.type == '1' ? Color.fromRGBO(255, 97, 97, 1) : Color.fromRGBO(1, 171, 245, 1),
      appBar: MorphingAppBar(
        title: Text(
          '典典请你吃饭',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [renderHeaderImage(), renderNavLink(), utils.widgetUtils.marginTop(), renderKl()],
        ),
      ),
    );
  }

  // 头部
  Widget renderHeaderImage() {
    return AspectRatio(aspectRatio: 1.87, child: Image.asset('assets/images/waimai/hb/${widget.type == '1' ? '1' : 'sc_bg'}.png'));
  }

  /// 复制口令模块
  Widget renderKl() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 2.33,
          child: Image.asset('assets/images/waimai/hb/4.png'),
        ),
        if (model != null)
          Positioned(
              left: 20,
              right: 20,
              top: 30,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${model!.longTpwd}',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    textAlign: TextAlign.center,
                  ))),
        Positioned(
          left: 30,
          right: 30,
          bottom: 40,
          child: FButton(
            height: 40,
            text: '复制饿了么口令',
            style: TextStyle(color: Colors.pink),
            onPressed: () {
              if (model != null) {
                utils.copy(model!.longTpwd, message: '复制口令成功,打开淘宝即可领取优惠券');
              }
            },
            clickEffect: true,
            strokeWidth: 1,
            strokeColor: Colors.red,
            alignment: Alignment.center,
            corner: FCorner.all(50),
            shadowColor: Colors.red,
            highlightColor: Colors.pink.shade50,
          ),
        )
      ],
    );
  }

  /// 跳转链接
  Widget renderNavLink() {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          Image.asset('assets/images/waimai/hb/2.png'),
          Positioned(
              top: 12,
              left: 20,
              right: 20,
              child: AspectRatio(
                aspectRatio: 3.98,
                child: Image.asset('assets/images/waimai/hb/3.png'),
              )),
          Positioned(
              bottom: 35,
              left: 30,
              right: 30,
              child: Container(
                child: FButton(
                  height: 40,
                  alignment: Alignment.center,
                  text: '领红包点外卖',
                  style: TextStyle(color: Colors.white),
                  color: Colors.red,
                  onPressed: () {
                    if (model != null) {
                      utils.navToBrowser(model!.clickUrl);
                    }
                  },
                  highlightColor: Colors.pink,
                  corner: FCorner.all(50),
                ),
              ))
        ],
      ),
    );
  }
}
