import 'dart:convert';

import 'package:demo1/common/utils.dart';
import 'package:demo1/constant/style.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';

import '../../../modals/goods_info.dart';

// 商品特殊组件显示

class GoodsText extends SpecialText {
  static final String flag = '[goodsId=';
  final int? start;
  @override
  final SpecialTextGestureTapCallback? onTap;

  GoodsText(TextStyle textStyle, {this.start, this.onTap})
      : super(flag, 'End]', textStyle);

  @override
  InlineSpan finishText() {
    var goodsText = getContent();

    var goodsInfo = GoodsInfo.fromJson(json.decode(goodsText));
    var dtitle = goodsInfo.data!.dtitle;
    var mainPic = goodsInfo.data!.mainPic!;
    var actualPrice = goodsInfo.data!.actualPrice.toString(); //券后价
    var discounts = goodsInfo.data!.discounts.toString(); // 折扣力度

    return ExtendedWidgetSpan(
        actualText: toString(),
        deleteAll: true,
        start: start!,
        child: GestureDetector(
          onTap: () {
            print('商品卡片被按下了');
            onTap?.call(goodsText);
          },
          child: PhysicalModel(
            color: Colors.grey.shade100,
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: <Widget>[
                  ExtendedImage.network(
                    mainPic,
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                    cache: true,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  utils.widgetUtils.marginRight(),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$dtitle',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15)),
                          FSuper(
                            lightOrientation: FLightOrientation.LeftBottom,
                            padding: EdgeInsets.fromLTRB(9, 6, 9, 6),
                            text: '¥',
                            spans: [
                              TextSpan(
                                text: '$actualPrice券后  ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                              TextSpan(
                                text: '$discounts折',
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                            backgroundColor: Colors.grey.shade100,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
