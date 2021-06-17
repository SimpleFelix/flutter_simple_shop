import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPublicLayout extends StatelessWidget {
  final Widget? child;
  final bool? transparencyBg; //是否透明背景
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  IndexPublicLayout(
      {this.child,
      this.transparencyBg,
      this.padding,
      this.margin,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null
          ? EdgeInsets.only(
              top: 10,
              left: ScreenUtil().setWidth(50),
              right: ScreenUtil().setWidth(50))
          : EdgeInsets.zero,
      child: PhysicalModel(
          color: Colors.grey.shade50,
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding:
                padding == null ? EdgeInsets.only(top: 10.0) : EdgeInsets.zero,
            child: child,
          )),
    );
    ;
  }
}
