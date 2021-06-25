import 'package:demo1/widgets/component/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/style.dart';
import 'widgets/simple_dialog.dart';

/// 组件工具类
abstract class WidgetUtilService {
  /// 垂直边距
  Widget marginTop({double? height});

  /// 横向边距
  Widget marginRight({double? width});

  /// 显示一个简单的弹窗提示
  Future<void> showSimpleDialog(String message,{String? title});

  Widget loading(double width,double height,{double? radius});
}

class WidgetUtils extends WidgetUtilService {
  double get kBodyHeight =>
      Get.height - Get.mediaQuery.padding.top - kToolbarHeight;

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

  @override
  Future<void> showSimpleDialog(String message,{String? title}) async {
    await Get.dialog(MySimpleDialog(
      message: message,
      title: title,
    ));
  }

  @override
  Widget loading(double width, double height,{double? radius}) {
    return Skeleton(width: width,height: height,cornerRadius: radius??4,);
  }
}
