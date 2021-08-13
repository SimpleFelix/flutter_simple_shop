// Flutter imports:
import 'package:flutter/material.dart';

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
              left: 12,
              right: 12)
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
  }
}
