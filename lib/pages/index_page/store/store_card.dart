import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/index_provider.dart';

class StoreItemCard extends StatelessWidget {
  final ListElement storeInfo;

  const StoreItemCard({Key? key, required this.storeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [_buildInfo(context)],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    var bgColor = Provider.of<IndexProvider>(context).brandBgColorMap[storeInfo.brandId];
    bgColor = bgColor ?? Colors.grey[200];
    return Container(
      height: 350.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 30.h),
      decoration: BoxDecoration(
        color: bgColor!.withOpacity(.05),
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
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
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                    ),
                    child: _buildLogo(),
                  ),
                  SizedBox(width: 30.w),
                  Text(
                    storeInfo.brandName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 55.sp, color: Colors.black),
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
    return Container(margin: EdgeInsets.only(top: 30.h),child: Text('${storeInfo.brandFeatures}', style: TextStyle(fontSize: 50.sp, color: Colors.black87)),);
  }

  /// 打折的组件
  Container _buildMaxDiscount() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Text(
        '最高优惠${storeInfo.maxDiscount}折',
        style: TextStyle(fontSize: 50.sp, color: Colors.white),
      ),
    );
  }

  Image _buildLogo() {
    return Image.network(
      storeInfo.brandLogo!,
      width: 100.w,
      height: 100.h,
    );
  }
}
