import 'package:demo1/widgets/extended_image.dart';
import 'package:demo1/widgets/loading_widget.dart';
import 'package:demo1/widgets/simple_price.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/api_service.dart';
import '../../widgets/simple_appbar.dart';
import 'abs.dart';
import 'model.dart';

/// 通用详情页面
class PublicDetailView extends StatefulWidget {
  final String goodsId;
  final String type;

  const PublicDetailView({Key? key, required this.goodsId, required this.type}) : super(key: key);

  @override
  _PublicDetailViewState createState() => _PublicDetailViewState();
}

class _PublicDetailViewState extends State<PublicDetailView> implements PublicDetailViewAbs {
  PublicDetailModel? info;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final _info = await fetchData();
      if (mounted) {
        setState(() {
          info = _info;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: '商品详情',
      ),
      body: info != null
          ? SingleChildScrollView(
              child: Column(
                children: [renderHeader()],
              ),
            )
          : LoadingWidget(),
    );
  }

  /// 头部容器
  Widget renderHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    '${info!.type}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '${info!.title}',
                  style: Get.textTheme.headline5,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minHeight: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '券后价',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                          Text('¥ ${info!.price}', style: TextStyle(color: Colors.red, fontSize: 18))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: SimpleImage(url: info!.goodsImage),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${info!.coupon}元隐藏券',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '去领券 >',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Future<PublicDetailModel?> fetchData() async {
    switch (widget.type) {
      case 'pdd':
        return await getPxxDetail();
      default:
        break;
    }
  }

  /// 加载拼夕夕商品详情
  Future<PublicDetailModel?> getPxxDetail() async {
    final result = await tkApi.ppdDetail(widget.goodsId);
    if (result != null) {
      return PublicDetailModel.fromPdd(result);
    }
  }

  @override
  Future<void> onGetCoupon() {
    throw UnimplementedError();
  }

  @override
  Future<void> onShare() {
    throw UnimplementedError();
  }
}
