import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import '../constant/color.dart';

// 券后价小部件
class CouponPriceWidget extends StatelessWidget {
  final String? actualPrice; //  券后价
  final double? originalPrice; //  商品原价
  final double? couponPriceFontSize; // 券后价文本大小
  final double? originalPriceFontSize; // 商品原价文本大小
  final double? interval; // 券后价和原价之间的间隔距离
  final bool? showDiscount; // 是否显示折扣

  CouponPriceWidget(
      {required this.actualPrice,
      required this.originalPrice,
      this.couponPriceFontSize,
      this.originalPriceFontSize,
      this.interval,
      this.showDiscount});

  late double couponPriceSymbolFontSize; // 券后价 人民币符号 字体大小

  @override
  Widget build(BuildContext context) {
    couponPriceSymbolFontSize = (couponPriceFontSize ?? 80.0) * 0.75;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 3.0),
            child: Text('券后',
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: ScreenUtil().setSp(couponPriceSymbolFontSize * 0.6))),
          ),
          Container(
            child: Text(
              '¥',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(couponPriceSymbolFontSize),
                  color: Colors.pinkAccent),
            ),
          ),
          Container(
            child: Text(
              actualPrice.toString(),
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: ScreenUtil().setSp(couponPriceFontSize ?? 80)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: interval ?? 10.0),
            child: Text(
              '¥$originalPrice',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black38,
                  fontSize: ScreenUtil().setSp(originalPriceFontSize ?? 50)),
            ),
          ),
          //多少折
          showDiscount != null && showDiscount! ? _buildDiscount() : Container()
        ],
      ),
    );
  }

  //计算多少折扣
  Widget _buildDiscount() {
    double discountDouble = double.parse(actualPrice!) / originalPrice!;
    String numStr = discountDouble.toStringAsFixed(2);
    numStr = numStr.substring(0, numStr.lastIndexOf('.') + 2);
    double discount = double.parse(numStr) * 10;
    return FSuper(
      lightOrientation: FLightOrientation.LeftBottom,
      backgroundColor: primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: EdgeInsets.only(left: 10),
      text: '${discount.toStringAsFixed(discount.truncateToDouble() == discount ? 0 : 1)}折',
    );
  }
}
