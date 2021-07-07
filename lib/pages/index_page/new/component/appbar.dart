import 'package:demo1/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsearch_nullsafety/fsearch_nullsafety.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../../provider/riverpod/category_riverpod.dart';
import '../index_riverpod.dart';

/// 首页导航栏
class IndexHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const IndexHomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MorphingAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: FSearch(
        backgroundColor: Colors.grey.shade50,
        padding: EdgeInsets.symmetric(vertical: 8),
        corner: FSearchCorner.all(5),
        hints: ['输入淘宝标题','复制淘宝链接','搜索你想要找的商品'],
        hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              color: Colors.black,
            ))
      ],
      leading: Container(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          'assets/svg/diandian.svg',
          width: 34,
          height: 34,
        ),
      ),
      leadingWidth: 45,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final loading = watch(indexRiverpod).indexLoading;
            final categoryWidgets = utils.widgetUtils.categoryTabs(context);
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 800),
                      height: 46,
                      child: DefaultTabController(
                        length: 1 + categoryWidgets.length,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            isScrollable: true,
                            tabs: [
                              Tab(
                                text: '精选',
                              ),
                              ...categoryWidgets
                            ],
                            labelColor: Colors.black,
                            indicatorColor: Colors.transparent,
                            unselectedLabelColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: loading
                          ? LinearProgressIndicator(
                              minHeight: 2.0,
                            )
                          : Container(
                              height: 2.0,
                            ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48 * 2);
}
