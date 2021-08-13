// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:palette_generator/palette_generator.dart';

// Project imports:
import 'package:demo1/util/image_util.dart';

class ColorUtil{

  /// 获取图片的主要颜色
  static Future<Color> getImageMainColor(String netImageUrl)async{
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(MImageUtils.magesProcessor(netImageUrl)),
      maximumColorCount: 20,
    );
    return paletteGenerator.dominantColor!.color;
  }
}
