import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repository.dart';

class CategorysWithPanicBuying extends ConsumerWidget implements PreferredSizeWidget {
  final List<Tab>? insets;

  CategorysWithPanicBuying({this.insets});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isLoading = watch(panicBuyingRiverpod).initLoading;
    final cates = watch(panicBuyingRiverpod).cates;
    if (isLoading) return Container();
    var _insets = insets ?? [];
    return DefaultTabController(
      length: cates.length + _insets.length,
      child: TabBar(
        tabs: [..._insets, ...cates.map(_renderItem).toList()],
        isScrollable: true,
        indicator: BubbleTabIndicator(
          indicatorHeight: 25.0,
          indicatorColor: Colors.pink,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        unselectedLabelColor: Colors.black.withOpacity(.67),
        labelColor: Colors.white,
      ),
    );
  }

  // 渲染分类
  Widget _renderItem(Category item) {
    return Tab(
      child: Text('${item.cname}'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
