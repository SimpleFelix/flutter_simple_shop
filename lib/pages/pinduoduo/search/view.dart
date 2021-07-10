import 'package:demo1/pages/pinduoduo/search/model.dart';
import 'package:demo1/widgets/appbar_search.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:demo1/widgets/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchLogic logic = Get.put(SearchLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBarSearch(
        hintText: '搜索拼多多隐藏优惠券',
        onSearch: logic.onSearch,
      ),
      body: EasyRefresh.custom(slivers: [
        /// 拼多多商品列表
        Obx(() {
          final products = logic.products;
          print(products.length);
          return SliverList(delegate: SliverChildBuilderDelegate((_, index) => renderItem(products[index]), childCount: products.length));
        })
      ]),
    );
  }

  Widget renderItem(PddDetail item) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: SimpleImage(
                  url: '${item.goodsImageUrl}',
                ),
              ),
              Expanded(
                  child: Column(
                children: [Text('${item.goodsName}')],
              ))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }
}
