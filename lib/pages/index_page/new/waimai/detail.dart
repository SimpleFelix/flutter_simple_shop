import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/activity-link_result.dart';
import 'package:dd_taoke_sdk/params/activity_link_param.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

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
      appBar: MorphingAppBar(
        title: Text('外卖红包',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
    );
  }
}
