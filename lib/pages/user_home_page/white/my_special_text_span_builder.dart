import 'package:flutter/material.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'at_text.dart';
import 'image_render.dart';
import 'product_render.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  final bool showAtBackground;
  final SpecialTextGestureTapCallback? atTextOnTap;
  final SpecialTextGestureTapCallback? goodsCardOnTapCallBack;

  MySpecialTextSpanBuilder({
    this.showAtBackground = false,
    this.goodsCardOnTapCallBack,
    this.atTextOnTap,
  });

  @override
  TextSpan build(String data, {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText? createSpecialText(String flag, {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap, int? index}) {
    if (flag == '') return null;

    ///索引是开始标志的结束索引，所以文本开始索引应该是Index -(flag.length-1)
    if (isStart(flag, AtText.flag)) {
      return AtText(
        textStyle!,
        onTap,
        start: index! - (AtText.flag.length - 1),
        showAtBackground: showAtBackground,
        onAtTextTap: atTextOnTap
      );
    } else if (isStart(flag, ImageText.flag)) {
      return ImageText(textStyle!, start: index! - (ImageText.flag.length - 1), onTap: onTap);
    } else if (isStart(flag, GoodsText.flag)) {
      return GoodsText(textStyle!, start: index! - (GoodsText.flag.length - 1), onTap: goodsCardOnTapCallBack);
    }
    return null;
  }
}
