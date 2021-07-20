import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/index_provider.dart';

// 品牌特卖
class StoreItemCard extends StatelessWidget {
  final ListElement storeInfo;

  const StoreItemCard({Key? key, required this.storeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [_buildInfo(context)],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    var bgColor = Provider.of<IndexProvider>(context).brandBgColorMap[storeInfo.brandId];
    bgColor = bgColor ?? Colors.grey[200];
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: bgColor!.withOpacity(.05),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: _buildLogo(),
                  ),
                  SizedBox(width: 12),
                  Text(
                    storeInfo.brandName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  )
                ],
              ),
              _buildMaxDiscount()
            ],
          ),
          _buildBrandFeatures(),
          Text('近期销量${storeInfo.sales}件'),
        ],
      ),
    );
  }

  Widget _buildBrandFeatures() {
    return Container(margin: EdgeInsets.only(top: 12),child: Text('${storeInfo.brandFeatures}', style: TextStyle(fontSize: 12, color: Colors.black87)),);
  }

  /// 打折的组件
  Container _buildMaxDiscount() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        '最高优惠${storeInfo.maxDiscount}折',
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }

  Image _buildLogo() {
    return Image.network(
      storeInfo.brandLogo!,
      width: 12,
      height: 12,
    );
  }
}
