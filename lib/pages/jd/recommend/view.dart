// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:extended_image/extended_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

// Project imports:
import '../../../widgets/loading_widget.dart';
import 'logic.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final RecommendLogic logic = Get.put(RecommendLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final loading = logic.loading.value;
        return AnimatedSwitcher(
          duration: Duration(
            seconds: 1,
          ),
          child: loading ? LoadingWidget() : renderProducts(),
        );
      }),
    );
  }

  Widget renderProducts() {
    final items = logic.products;
    return EasyRefresh(
      onLoad: logic.nextPage,
      child: WaterfallFlow.builder(
        itemBuilder: itemBuilder,
        itemCount: items.length,
        padding: EdgeInsets.all(12),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final item = logic.products[index];
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ExtendedImage.network(
                  item.picMain,
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                );
              },
            ),
            SizedBox(
              height: 4,
            ),
            // 第一行
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 产品类型
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), gradient: LinearGradient(colors: [Colors.pink, Colors.pinkAccent])),
                  child: Text(
                    '京东',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                // 好评率
                Text(
                  '好评${item.goodsCommentShare}%'.replaceAll('.0', ''),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            // 标题
            Text(
              '${item.skuName}',
              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 4,
            ),
            // 券
            // Row(
            //   children: [
            //     Text('${item.couponAmount}元券')
            //   ],
            // ),
            // 价格
            Row(
              children: [
                RichText(
                  text: TextSpan(text: '￥', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold), children: [
                    TextSpan(
                      text: '${item.actualPrice}',
                      style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<RecommendLogic>();
    super.dispose();
  }
}
