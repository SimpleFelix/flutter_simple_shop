// Flutter imports:
// Package imports:
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../../widgets/appbar_search.dart';
import '../../../search/view.dart';

/// 首页导航栏
class IndexHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const IndexHomeAppbar({Key? key}) : super(key: key);

  void navTo(BuildContext context) {
    context.navigator.push(SwipeablePageRoute(
        builder: (_) => SearchPage(
              initSearchKeyWord: '',
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SAppBarSearch(
      hintText: '输入关键字,例如:"手机"',
      onTap: () => navTo(context),
      readOnly: true,
      eve: 0,
      // leadingWidth: 58,
      // leading: Container(
      //   alignment: Alignment.center,
      //   child: SvgPicture.asset(
      //     'assets/svg/diandian.svg',
      //     width: 34,
      //     height: 34,
      //   ),
      // ),
      // actions: [
      //   IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.message,
      //         color: Colors.black,
      //       ))
      // ],
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(48),
      //   child: Consumer(
      //     builder: (BuildContext context,
      //         T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
      //       final loading = watch(indexRiverpod).indexLoading;
      //       final categoryWidgets = utils.widgetUtils.categoryTabs(context);
      //       return LayoutBuilder(
      //         builder: (BuildContext context, BoxConstraints constraints) {
      //           return Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               AnimatedContainer(
      //                 duration: Duration(milliseconds: 800),
      //                 height: 46,
      //                 child: DefaultTabController(
      //                   length: 1 + categoryWidgets.length,
      //                   child: Container(
      //                     alignment: Alignment.centerLeft,
      //                     child: TabBar(
      //                       isScrollable: true,
      //                       tabs: [
      //                         Tab(
      //                           text: '精选',
      //                         ),
      //                         ...categoryWidgets
      //                       ],
      //                       labelColor: Colors.black,
      //                       indicatorColor: Colors.transparent,
      //                       unselectedLabelColor: Colors.grey,
      //                       onTap: (int index) {
      //                         if (index == 0) {
      //                           return;
      //                         }
      //                         final category = context
      //                             .read(categoryRiverpod)
      //                             .getCategoryByIndex(index - 1);
      //                         utils.widgetUtils.to(NewGoodsList(
      //                           category: category,
      //                           initIndex: context
      //                               .read(categoryRiverpod)
      //                               .getIndexWithCategory(category),
      //                         ));
      //                       },
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               AnimatedSwitcher(
      //                 duration: Duration(milliseconds: 300),
      //                 child: loading
      //                     ? LinearProgressIndicator(
      //                         minHeight: 2.0,
      //                       )
      //                     : Container(
      //                         height: 2.0,
      //                       ),
      //               )
      //             ],
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
