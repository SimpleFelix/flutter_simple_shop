import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/params/brand_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/widgets/loading_mixin.dart';
import '../../provider/riverpod/category_riverpod.dart';
import '../index_page/component/category_component.dart';
import 'category_delegate.dart';
import 'components/item.dart';

/// 品牌列表页面
class BrandListPage extends StatefulWidget {
  @override
  _BrandListPageState createState() => _BrandListPageState();
}

class _BrandListPageState extends State<BrandListPage> with LoadingMixin {
  final CategoryController _categoryController = CategoryController();
  final EasyRefreshController _easyRefreshController = EasyRefreshController();
  int page = 1;
  int size = 20;
  int cid = 0;
  List<ListElement> lists = [];

  @override
  void initState() {
    super.initState();
    cid = context.read(categoryRiverpod).categorys[0].cid!;
    Future.microtask(() async {
      setLoading(true);
      final result = await DdTaokeSdk.instance
          .getBrandList(param: BrandListParam(cid: '$cid', pageId: '$page', pageSize: '$size'));
      if (result != null) {
        lists.addAll(result.lists ?? []);
      }
      setLoading(false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('品牌特卖'),
        elevation: 0,
      ),
      body: EasyRefresh.custom(
        controller: _easyRefreshController,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        slivers: [
          SliverPersistentHeader(
            delegate: CategoryDelegate(_categoryOnSelect, _categoryController),
            floating: true,
          ),
          SliverWaterfallFlow.count(crossAxisCount: 1, children: _items())
        ],
        onRefresh: _refresh,
        onLoad: _load,
      ),
    );
  }

  List<Widget> _items() => lists
      .map((e) => BrandItemCard(
            storeInfo: e,
          ))
      .toList();

  /// 刷新页面
  Future<void> _refresh() async {
    _easyRefreshController.finishRefresh();
  }

  /// 加载下一页
  Future<void> _load() async {
    _easyRefreshController.finishLoad();
  }

  /// 菜单被选择
  void _categoryOnSelect(int index, Category item) async {
    _categoryController.toIndex(index);
    cid = item.cid!;
    _easyRefreshController.callRefresh();
  }
}
