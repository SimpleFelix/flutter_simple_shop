// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:get/get.dart';

// Project imports:
import './goods_item_widget.dart';

class GoodsListWidget extends StatelessWidget {

  final List<Product>? list;
  final bool? isInitLoading;
  GoodsListWidget({required this.list,this.isInitLoading});

  @override
  Widget build(BuildContext context) {
    return isInitLoading!? Container(
      height:250,
      width: Get.width,
      child: Center(
        child: Image.asset("assets/images/loading.gif"),
      ),
    ) : Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: list!.length,
        itemBuilder: (context,index){
          return GoodsItemWidget(goodsItem: list![index]);
        },
      ),
    );
  }
}
