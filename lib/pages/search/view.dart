import 'package:demo1/widgets/appbar_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'component/helper_show.dart';
import 'component/suggest.dart';
import 'logic.dart';

/// 搜索页面
class SearchPage extends StatefulWidget {
  final String? initSearchKeyWord; // 初始化搜索关键字

  const SearchPage({Key? key, this.initSearchKeyWord}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchLogic logic = Get.put(SearchLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBarSearch(
        value: widget.initSearchKeyWord,
        bgColor: Colors.white,
      ),
      body: EasyRefresh.custom(slivers: [
        SliverToBoxAdapter(
          child: HelperComp(),
        ),
        SliverToBoxAdapter(
          child: Suggest(),
        )
      ]),
    );
  }

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }
}
