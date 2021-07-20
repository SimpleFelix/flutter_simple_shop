import 'package:after_layout/after_layout.dart';
import 'package:dd_taoke_sdk/constant/sort.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:demo1/pages/new_goods_list/components/sort_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/RoundUnderlineTabIndicator.dart';
import '../../widgets/StickyTabBarDelegate.dart';
import '../../widgets/simple_appbar.dart';
import '../panic_buying/components/categorys.dart';
import '../panic_buying/components/list.dart';
import 'components/subcategory_view.dart';
import 'riverpod.dart';

/// 新的商品列表
class NewGoodsList extends StatefulWidget {
  final Category category;
  final Subcategory? subcategory;
  final int? initIndex;

  const NewGoodsList({Key? key, required this.category, this.subcategory, this.initIndex}) : super(key: key);

  @override
  _NewGoodsListState createState() => _NewGoodsListState();
}
class _NewGoodsListState extends State<NewGoodsList> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read(goodsListRiverpod).setCategory(widget.category, widget.subcategory, isInit: true);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: '产品列表',
        bottom: BottomCategoryTabs(
          onTap: (int index) => context.read(goodsListRiverpod).mainCateChange(index, context),
          initIndex: widget.initIndex,
        ),
        bottomHeight: 48,
      ),
      body: EasyRefresh.custom(onLoad: context.read(goodsListRiverpod).nextPage, onRefresh: context.read(goodsListRiverpod).onRefresh, header: MaterialHeader(), footer: MaterialFooter(), slivers: [
        Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final cate = watch(goodsListRiverpod).category;
            final subCate = watch(goodsListRiverpod).subcategory;
            return SliverToBoxAdapter(
              child: SubCategoryView(
                cate,
                changeSubcategory: (subcategory) {
                  context.read(goodsListRiverpod).setCategory(cate, subcategory);
                  context.read(goodsListRiverpod).onRefresh();
                },
                subcategory: subCate,
              ),
            );
          },
        ),

        // 排序
        Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final current = watch(goodsListRiverpod).sort;
            return //排序
                SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                    onTap: context.read(goodsListRiverpod).sortChange,
                    labelColor: Colors.pinkAccent,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.pinkAccent,
                    indicator: RoundUnderlineTabIndicator(
                        borderSide: BorderSide(
                      width: 2,
                      color: Colors.pinkAccent,
                    )),
                    controller: _tabController,
                    tabs: <Widget>[
                      SortWidget(
                        title: '人气',
                        current: current == DdSort.defaultSort,
                      ),
                      SortWidget(
                        title: '最新',
                        current: current == DdSort.timeHighToLow,
                      ),
                      SortWidget(
                        title: '销量',
                        current: current == DdSort.salesHighToLow,
                      ),
                      SortWidget(title: '价格', current: current == DdSort.priceLowToHigh, icon: _bulidPriceIconWidget(current)),
                    ]),
              ),
            );
          },
        ),

        // 刷新指示器
        Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final loading = watch(goodsListRiverpod).loading;
            if (loading) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            return SliverToBoxAdapter();
          },
        ),

        // 产品列表
        Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final products = watch(goodsListRiverpod).products;
            return ProductsList(products);
          },
        ),
      ]),
    );
  }

  // 价格排序图标改变 (从高到低/从低到高)
  Widget _bulidPriceIconWidget(String current) {
    var iconShow = 'assets/icons/px.png';
    if (current == '5') {
      iconShow = 'assets/icons/pxx.png';
    }
    if (current == '6') {
      iconShow = 'assets/icons/pxs.png';
    }
    return Image.asset(
      iconShow,
      height: 12,
      width: 12,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await context.read(goodsListRiverpod).onRefresh();
  }
}
