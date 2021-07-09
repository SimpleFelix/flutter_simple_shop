import 'package:dd_taoke_sdk/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import './sort_widget.dart';
import '../../provider/riverpod/category_riverpod.dart';
import '../../repository/goods_list_repository.dart';
import '../../util/fluro_convert_util.dart';
import '../../widgets/RoundUnderlineTabIndicator.dart';
import '../../widgets/StickyTabBarDelegate.dart';
import '../../widgets/loading_more_list_indicator.dart';
import '../../widgets/waterfall_goods_card.dart';
import 'subcategory_view.dart';

///

/// 商品列表通用页面

///

class GoodsListPage extends StatefulWidget {
  final String? subcid;
  final String? cids;
  final String? brand;
  final String? title;
  final  String? showCates; // 是否显示分类选择
  GoodsListPage(
      {this.subcid, this.cids, this.brand, this.title, this.showCates = '0'});

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage>
    with TickerProviderStateMixin {
  bool showToTopBtn = false; //是否显示到达顶部按钮
  bool changeSortIng = false; // 切换排序中
  late TabController _tabController; // 排序tab控制器
  late TabController categorysTabBarController; //主分类tab控制器
  late GoodsListRepository goodsListRepository;
  List<int> curs = [0, 1, 2, 5, 6];
  int current = 0;
  int priceSortType = 0; // 0:从高到低,1:从低到高
  String? initCid; // 分类初始化默认选中
  String? currentSubCategory; // 选中的子分类
  String? currentMainCategory;// 选中的主分类

  @override
  Widget build(BuildContext context) {
    var t = FluroConvertUtils.fluroCnParamsDecode(widget.title!);
    return WillPopScope(
      onWillPop: () async {
        return Future<bool>.value(true);
      },
      child: Scaffold(
        appBar: MorphingAppBar(
          title: Text(t),
          leading: BackButton(
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: PullToRefreshNotification(
          pullBackOnRefresh: true,
          maxDragOffset: 80.0,
          onRefresh: () async {
            await goodsListRepository.refresh(true);
            return true;
          },
          child: LoadingMoreCustomScrollView(
            rebuildCustomScrollView: true,
            slivers: <Widget>[
              // 下拉刷新指示头
              PullToRefreshContainer(buildPulltoRefreshHeader),
              //主分类e
              buildTopCategorys(),

              //子分类
              // SliverToBoxAdapter(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //     ),
              //     child: SubCategoryView(changeSubcategory: (subcategory){
              //       setState(() {
              //         currentSubCategory = subcategory.subcid.toString();
              //         currentMainCategory = '';
              //         goodsListRepository = GoodsListRepository(
              //             cids: '',
              //             sortStr: '0',
              //             subcid: subcategory.subcid.toString(),
              //             brand: '');
              //       });
              //       goodsListRepository.refresh(true);
              //       _tabController.animateTo(0);
              //     },),
              //   ) ,
              // ),

              //排序
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: TabBar(
                      onTap: sortOnChange,
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
                          current: current == 0,
                        ),
                        SortWidget(
                          title: '最新',
                          current: current == 1,
                        ),
                        SortWidget(
                          title: '销量',
                          current: current == 2,
                        ),
                        SortWidget(
                            title: '价格',
                            current: current == 3,
                            icon: _bulidPriceIconWidget()),
                      ]),
                ),
              ),
              // 商品列表
              LoadingMoreSliverList(SliverListConfig<Product>(
                sourceList: goodsListRepository,
                extendedListDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, item, index) =>
                    WaterfallGoodsCard(item),
                indicatorBuilder: (context, state) {
                  return LoadingMoreListCostumIndicator(state,
                      isSliver: true);
                },
              ))
            ],
          ),
        ),
      ),
    );
  }



  // 顶部主分类tab
  Widget buildTopCategorys() {
    final categorys = context.read(categoryRiverpod).categorys;
    var tabs = categorys.map((item) {
      return Tab(text: item.cname);
    }).toList();
    tabs.insert(0, Tab(text: '首页'));
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
          child: TabBar(

        onTap: (index) async {
          if (index != 0) {
            setState(() {
              currentMainCategory = categorys[index - 1].cid.toString();
              currentSubCategory = '';
              goodsListRepository = GoodsListRepository(
                  cids: categorys[index - 1].cid.toString(),
                  sortStr: '0',
                  subcid: '',
                  brand: '');
            });
            changeSubCategory(index - 1);
            _tabController.animateTo(0);
            await goodsListRepository.refresh(true);
          } else {
            Navigator.pop(context);
          }
        },
        controller: categorysTabBarController,
        tabs:  tabs,
        indicator: RoundUnderlineTabIndicator(
            insets: EdgeInsets.only(bottom: 8),
            borderSide: BorderSide(
              width: 2,
              color: Colors.pinkAccent,
            )),
        unselectedLabelColor: Colors.black,
        labelColor: Colors.pinkAccent,
        isScrollable: true,
      )),
    );
  }

  @override
  void initState() {
    goodsListRepository = GoodsListRepository(
        cids: widget.subcid!=''  ? '' : widget.cids,
        brand: widget.brand,
        subcid: widget.subcid,
        sortStr: '0');
    _tabController = TabController(vsync: this, length: 4);
    categorysTabBarController = TabController(vsync: this, length: context.read(categoryRiverpod).categorys.length+1);
    setState(() {
      currentSubCategory = widget.subcid ?? '';
      currentMainCategory = widget.cids;
    });
    super.initState();
  }


  // 主分类初始下标获取
  int getInitCategoryTabIndex() {
    final categorys = context.read(categoryRiverpod).categorys;
    var cid = widget.cids;
    for (var item in categorys) {
      if (item.cid.toString() == cid) {
        return categorys.indexOf(item) + 1;
      }
    }
    return 0;
  }

  // 供排序使用
 void _setCurrent(int c) {
    setState(() {
      current = c;
    });
  }

  // 价格排序图标改变 (从高到低/从低到高)
  Widget _bulidPriceIconWidget() {
    var iconShow = 'assets/icons/px.png';
    if (current == 3) {
      iconShow = 'assets/icons/pxx.png';
    }
    if (current == 4) {
      iconShow = 'assets/icons/pxs.png';
    }
    return Image.asset(
      iconShow,
      height: ScreenUtil().setHeight(60),
      width: ScreenUtil().setWidth(60),
    );
  }

  // 排序被改变
 Future<void> sortOnChange(int index) async {
    if (index == 3 && priceSortType == 1) {
      _setCurrent(index);
      goodsListRepository = GoodsListRepository(
          cids: currentMainCategory,
          brand: widget.brand,
          subcid: currentSubCategory,
          sortStr: '$index');
      await goodsListRepository.refresh(true);
      setState(() {
        priceSortType = 0;
      });
      return;
    }
    if (index == 3 && priceSortType == 0) {
      _setCurrent(4);
      goodsListRepository = GoodsListRepository(
          cids: currentMainCategory,
          brand: widget.brand,
          subcid: currentSubCategory,
          sortStr: '4');
      await goodsListRepository.refresh(true);
      setState(() {
        priceSortType = 1;
      });
      return;
    }

    if (current != index) {
      _setCurrent(index);
      goodsListRepository = GoodsListRepository(
          cids: currentMainCategory,
          brand: widget.brand,
          subcid: currentSubCategory,
          sortStr: '$index');
      await goodsListRepository.refresh(true);
    }
  }

  // 传入主分类的下标
  void changeSubCategory(int index) {
    final categorys = context.read(categoryRiverpod).categorys;
    context.read(categoryRiverpod).setCurrentWithProductList(categorys[index]);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget buildPulltoRefreshHeader(PullToRefreshScrollNotificationInfo? info) {
    //print(info?.mode);
    //print(info?.dragOffset);
    //    print('------------');
    var offset = info?.dragOffset ?? 0.0;
    var mode = info?.mode;
    // Widget refreshWiget = Container();
    //it should more than 18, so that RefreshProgressIndicator can be shown fully
    if (info?.refreshWidget != null &&
        offset > 18.0 &&
        mode != RefreshIndicatorMode.error) {
      // refreshWiget = info.refreshWiget;
    }

    Widget child;
    if (mode == RefreshIndicatorMode.error) {
      child = GestureDetector(
          onTap: () {
            // refreshNotification;
            info?.pullToRefreshNotificationState.show();
          },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            height: offset,
            width: double.infinity,
            //padding: EdgeInsets.only(top: offset),
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              alignment: Alignment.center,
              child: Text(
                '刷新失败,点击重试',
                style: TextStyle(fontSize: 12.0, inherit: false),
              ),
            ),
          ));
    } else {
      var modeStr = '下拉刷新';
      if (mode != null && mode == RefreshIndicatorMode.armed) {
        modeStr = '松手刷新';
      } else if (mode != null && mode == RefreshIndicatorMode.snap) {
        modeStr = '请求数据中';
      } else if (mode != null && mode == RefreshIndicatorMode.canceled) {
        modeStr = '操作取消';
      } else if (mode != null && mode == RefreshIndicatorMode.done) {
        modeStr = '刷新成功';
      } else if (mode != null && mode == RefreshIndicatorMode.refresh) {
        modeStr = '正在刷新';
      }
      child = Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        height: offset,
        width: double.infinity,
        //padding: EdgeInsets.only(top: offset),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/loading.gif'),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                '$modeStr',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(50),
                    inherit: false,
                    color: Colors.grey),
              ),
            )
          ],
        ),
      );
    }
    return SliverToBoxAdapter(
      child: child,
    );
  }
}
