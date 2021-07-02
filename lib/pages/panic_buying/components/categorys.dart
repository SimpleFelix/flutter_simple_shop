import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils.dart';
import '../repository.dart';

class CategorysWithPanicBuying extends ConsumerWidget implements PreferredSizeWidget {
  final List<Tab>? insets;

  CategorysWithPanicBuying({this.insets});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var _insets = insets ?? [];
    final categoryWidgets = utils.widgetUtils.categoryTabs(context);
    return Container(
      alignment: Alignment.centerLeft,
      child: DefaultTabController(
        length: categoryWidgets.length + _insets.length,
        child: TabBar(
          tabs: [..._insets, ...categoryWidgets],
          isScrollable: true,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: Colors.pink,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          unselectedLabelColor: Colors.black.withOpacity(.67),
          labelColor: Colors.white,
          onTap: context.read(panicBuyingRiverpod).tabChanged,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
