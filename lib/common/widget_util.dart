import 'package:demo1/constant/style.dart';
import 'package:flutter/cupertino.dart';

/// 组件工具类
abstract class WidgetUtilService {

  /// 垂直边距
  Widget marginTop({double? height});

  /// 横向边距
  Widget marginRight({double? width});
}

class WidgetUtils extends WidgetUtilService {
  @override
  Widget marginTop({double? height}) {
    return SizedBox(
      height: height ?? kDefaultPadding,
    );
  }

  @override
  Widget marginRight({double? width}) {
    return SizedBox(
      width: width ?? kDefaultPadding,
    );
  }
}
