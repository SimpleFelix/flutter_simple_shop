import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/riverpod/search_riverpod.dart';
import '../../widgets/appbar_search.dart';
import 'component/product_list.dart';

/// 搜索结果页面
class SearchListIndex extends StatelessWidget {
  final String value;

  const SearchListIndex({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBarSearch(
        value: value,
        bgColor: Colors.white,
      ),
      body: EasyRefresh.custom(
        slivers: [
          SliverToBoxAdapter(
            child: SearchProductList(),
          )
        ],
        onLoad: context.read(searchRiverpod).nextPage,
        footer: MaterialFooter(),
      ),
    );
  }
}
