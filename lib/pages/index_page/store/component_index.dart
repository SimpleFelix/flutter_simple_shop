// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../common/utils.dart';
import '../../../provider/index_provider.dart';
import '../component/component_title.dart';
import 'goods_card.dart';

/// 首页推荐商店模块
class StoreComponentIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeData = context.watch<IndexProvider>().storeData;
    if (storeData != null) {
      return Container(
            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: PhysicalModel(
              color: Colors.grey.shade50,
              elevation: 3,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    utils.widgetUtils.marginTop(height: 12),
                    ComponentTitle(title: '今日品牌推荐', height: 100),
                    // StoreItemCard(storeInfo: storeData.lists![0]),
                    utils.widgetUtils.marginTop(),
                    StoreGoodsCard(
                      storeInfo: storeData.lists![0],
                    )
                  ],
                ),
              ),
            ),
          );
    } else {
      return Container();
    }
  }
}
