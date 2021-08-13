// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../provider/riverpod/search_riverpod.dart';
import '../../widgets/appbar_search.dart';
import 'component/helper_show.dart';
import 'component/key_worlds.dart';
import 'component/suggest.dart';
import 'list.dart';
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
        onSearch: (String value) {
          context.read(searchRiverpod).loadData(worlds: value);
          Get.to(() => SearchListIndex(value: value));
        },
        eve: 3,
      ),
      body: EasyRefresh.custom(slivers: [
        SliverToBoxAdapter(
          child: HelperComp(),
        ),
        SliverToBoxAdapter(
          child: SearchKeyWorlds(),
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
