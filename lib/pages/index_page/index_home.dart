// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:after_layout/after_layout.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/model/product.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide NestedScrollView;
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import './ddq.dart';
// Project imports:
import '../../repository/index_goods_repository.dart';
import '../../widgets/flexd/index_header_flexd_widget.dart';
import '../../widgets/loading_more_list_indicator.dart';
import '../../widgets/my_clipper.dart';
import '../../widgets/pullto_refresh_header.dart';
import '../../widgets/waterfall_goods_card.dart';
import '../search/view.dart';
import 'component/category_component.dart';
import 'component/category_item_layout.dart';
import 'component/topic_carousel.dart';

/// 首页
class IndexHome extends StatefulWidget {
  final ScrollController? mController;

  IndexHome({Key? key, this.mController}) : super(key: key);

  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome>
    with TickerProviderStateMixin, AfterLayoutMixin<IndexHome> {
//   状态管理
  final GlobalKey _titleKey = GlobalKey();

  bool _titleIsInTop = false;

  //dddd
  IndexGoodsRepository indexGoodsRepository = IndexGoodsRepository();
  final ScrollController _mainScrollController = ScrollController();

  TabController? tabController;

  final TextEditingController _searchEditController = TextEditingController();

  bool carouselISLoaded = false; // 轮播图资源是否准备完毕
  bool categortListIsLoaded = false; // 分类数据是否准备好
  Color? bgColor;
  int carouselHeight = 500; // 轮播图高度

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PullToRefreshNotification(
        pullBackOnRefresh: false,
        maxDragOffset: 80.0,
        armedDragUpCancel: false,
        onRefresh: () async {
          await indexGoodsRepository.refresh(true);
          return true;
        },
        child: _buildIndexBody());
  }

  // 首页商品列表
  Widget _buildGoodsList() {
    return LoadingMoreSliverList(SliverListConfig<Product>(
      extendedListDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12),
      itemBuilder: (context, item, index) {
        return PhysicalModel(
          color: Colors.grey.shade50,
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: WaterfallGoodsCard(item),
        );
      },
      sourceList: indexGoodsRepository,
      padding: EdgeInsets.only(
          left: 12, right: 12),
//      lastChildLayoutType: LastChildLayoutType.foot,
      indicatorBuilder: (context, state) {
        return LoadingMoreListCostumIndicator(state, isSliver: true);
      },
    ));
  }

  /// 初始化数据
  /// 从上往下顺序加载
  Future<void> _initDatas() async {
    setState(() {
      carouselISLoaded = true;
    });
    // await context.read<DtkIndexGoodsModal>().getGoodsList(1); // 首页商品列表
    // setState(() {
    //   tabController = TabController(length: categorys.length + 1, vsync: this);
    //   setState(() {
    //     categortListIsLoaded = true;
    //   });
    // });
  }

  // body
  Widget _buildIndexBody() {
    return LoadingMoreCustomScrollView(
      controller: _mainScrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: IndexFlexdHeaderWidget(child: [
            _buildAppbar(),
            CategoryComponent(
              extendItems: [
                InsetCustomItem(
                    index: 0,
                    child: CategoryItemDefaultLayout(
                      name: '首页',
                      index: 0,
                      onRendeEnd: (int? index, Offset offset, Size? size) {},
                    ),
                    onTap: () {
                      print('我点击了首页');
                    }),
              ],
              onSelect: (int index, Category? item) {
                if (item != null) {
                  print('选中了:${item.cname},index是:$index');
                }
              },
            ),
          ]),
          floating: true,
          pinned: true,
        ),

        // appbar和tab和轮播图
        SliverToBoxAdapter(
          child: _buildIndexTopWidgets(),
        ),

        // 下拉刷新指示头
        PullToRefreshContainer(buildPulltoRefreshHeader),

        // 网格菜单

        //钉钉抢
        SliverToBoxAdapter(
          child: DDQWidget(),
        ),

        // 品牌推荐
        // SliverToBoxAdapter(
        //   child: StoreComponentIndex(),
        // ),

        // SliverToBoxAdapter(
        //   child: HodgepodgeWidget(),
        // ),

        /// 商品列表标题
        // SliverPersistentHeader(
        //   pinned: true,
        //   delegate: IndexMainGoodsMiniTitleBar(
        //       height: 60,
        //       child: AnimatedContainer(
        //         key: _titleKey,
        //         duration: Duration(milliseconds: 300),
        //         decoration: BoxDecoration(
        //             color: _titleIsInTop
        //                 ? Colors.white
        //                 : Colors.white),
        //         child: CustomSelectToolbar(items: [
        //           SelectMenu(title: '佛系推荐', subTitle: '发现好物'),
        //           SelectMenu(title: '精选', subTitle: '猜你喜欢'),
        //         ], select: 0, hideSubTitle: _titleIsInTop),
        //       )),
        // ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              '随便看看',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        //商品列表 (瀑布流)
        _buildGoodsList(),
      ],
    );
  }

  // 曲线
  Widget _buildIndexTopWidgets() {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: MyClipper(),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: carouselHeight + 50,
            )),
        Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            IndexTopicComponentCarousel(list: [],)
            // carouselISLoaded && carouselProviderModal.carousels.isNotEmpty
            //     ? IndexTopSwiper(
            //         carouselProviderModal: this.carouselProviderModal,
            //         datum: cpm.carousels,
            //         height: carouselHeight,
            //       )
            //     : _buildGJP()
          ],
        ),
      ],
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TextField(
        controller: _searchEditController,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        onTap: () {
          Get.to(() => SearchPage(
                initSearchKeyWord: '',
              ));
        },
        readOnly: true,
        decoration: InputDecoration(
          isDense: true,
          hintText: '输入商品名或者宝贝标题搜索',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none),
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.search)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //跳转到搜索页面
                  Navigator.pushNamed(context, 'search');
                },
                child: Icon(
                  Icons.message,
                  size: 12,
                ),
              ),
              Text(
                '消息',
                style: TextStyle(fontSize:12),
              )
            ],
          ),
        )
      ],
    );
  }

  //获取title的位置信息
  double _titleLocationHandler() {
    if (_titleKey.currentContext != null) {
      var renderBox = _titleKey.currentContext!.findRenderObject() as RenderBox;
      var offset = renderBox.localToGlobal(Offset(0, 0));
      return offset.dy;
    }
    return 0;
  }

  // 监听主滑动距离
  void _addMainScrollListening() {
    var topAppbarHei =
        111 + MediaQueryData.fromWindow(window).padding.top; // 顶部搜索框和选项卡高度
    _mainScrollController.addListener(() {
      var titleTopHei = _titleLocationHandler();
      if (titleTopHei <= topAppbarHei) {
        if (!_titleIsInTop) {
          setState(() {
            _titleIsInTop = true;
          });
        }
      } else {
        if (_titleIsInTop) {
          setState(() {
            _titleIsInTop = false;
          });
        }
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _titleLocationHandler();
    _addMainScrollListening();
    _initDatas();
  }
}
