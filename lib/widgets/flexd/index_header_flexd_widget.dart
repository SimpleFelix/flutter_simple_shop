import 'dart:ui';

import 'package:demo1/constant/style.dart';
import 'package:flutter/material.dart';

// 首页滑动置顶一
class IndexFlexdHeaderWidget extends SliverPersistentHeaderDelegate {
  final List<Widget>? child;
  final Color? color;

  IndexFlexdHeaderWidget({this.child, this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      color: color,
      child: SingleChildScrollView(
        child: Column(
          children: child!,
        ),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight + kHomeCateTabHeight + MediaQueryData.fromWindow(window).padding.top;

  @override
  double get minExtent => kToolbarHeight + kHomeCateTabHeight + MediaQueryData.fromWindow(window).padding.top;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
