// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:common_utils/common_utils.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/coupon_link_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart' as controller;
// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

// Project imports:
import '../../../common/utils.dart';
import '../../../modals/shop_info.dart';
import '../../../util/image_util.dart';
import '../../../widgets/extended_image.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/my_drawable_start_text.dart';
import '../../../widgets/no_data.dart';
import '../../../widgets/round_underline_tab_indicator.dart';
import '../../../widgets/simple_price.dart';
import '../detail_imgs_widget.dart';

class HaoDanKuDetailItem extends StatefulWidget {
  final String goodsId;

  HaoDanKuDetailItem({required this.goodsId});

  @override
  _HaoDanKuDetailItemState createState() => _HaoDanKuDetailItemState();
}

class _HaoDanKuDetailItemState extends State<HaoDanKuDetailItem> with TickerProviderStateMixin {
  late Product info;
  CouponLinkResult? couponLinkResult;
  ShopInfo? _shopInfo;
  late Future<String> futureBuildData;
  double _appbarOpaction = 0;
  int curentSwaiperIndex = 0;
  double ztlHei = MediaQueryData.fromWindow(window).padding.top; // 转态栏高度
  double _topAppbarHei = 0; // 顶部显影工具条的高度
  double _initImagesTopHei = 0; // 图片详情距离顶部的高度 (包含转态栏)
  bool _showToTopButton = false; // 显示返回顶部按钮

  TabController? _tabController;
  ScrollController? _scrollController;
  final GlobalKey _swaperGlogbalKey = GlobalKey();
  final GlobalKey _appbarGlogbalKey = GlobalKey();
  final GlobalKey _detailImagesGlogbalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    futureBuildData = initDatas();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _scrollController = ScrollController();
  }

  void addScrollListener() {
    _scrollController!.addListener(() {
      // 控制顶部导航显影
      var scrollHeight = _scrollController!.offset;
      var t = scrollHeight / (MediaQuery.of(context).size.width * 0.85);
      if (scrollHeight == 0) {
        t = 0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      setState(() {
        _appbarOpaction = t;
      });

      /// // 控制顶部导航显影

      //计算详情widget到顶部距离
      var topHei = getY(_detailImagesGlogbalKey.currentContext!);
      if (topHei <= _topAppbarHei + ztlHei) {
        _tabController!.animateTo(1);
      } else {
        if (_tabController!.index != 0) {
          _tabController!.animateTo(0);
        }
      }
    });
  }

  // 顶部选项卡被切换
  void tabOnChange(int index) {
    if (index == 0) {
      _scrollController!.animateTo(0, duration: Duration(milliseconds: 600), curve: Curves.ease);
    } else if (index == 1) {
      _scrollController!.animateTo(_initImagesTopHei - ztlHei - _topAppbarHei + 5, duration: Duration(milliseconds: 600), curve: Curves.ease);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController!.addListener(() {
      var scrollHeight = _scrollController!.offset;
      var t = scrollHeight / (MediaQuery.of(context).size.width * 0.85);
      if (scrollHeight == 0) {
        t = 0;
      } else if (t > 1.0) {
        t = 1.0;
        _showToTopButton = true;
      } else if (scrollHeight < 200) {
        _showToTopButton = false;
      }
      setState(() {
        _appbarOpaction = t;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.grey, statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: FutureBuilder(
        future: futureBuildData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            switchInCurve: Curves.fastOutSlowIn,
            child: snapshot.hasData
                ? buildCustomScrollViewShop()
                : snapshot.hasError
                    ? NoDataWidget(
                        title: snapshot.error.toString(),
                      )
                    : LoadingWidget(),
          );
        },
      ),
    );
  }

  Widget buildCustomScrollViewShop() {
    return NotificationListener<LayoutChangedNotification>(
      onNotification: (notification) {
        if (_topAppbarHei == 0) {
          setState(() {
            _topAppbarHei = _appbarGlogbalKey.currentContext!.size!.height + MediaQueryData.fromWindow(window).padding.top;
            _initImagesTopHei = getY(_detailImagesGlogbalKey.currentContext!);
          });
          addScrollListener();
        }
        return true;
      },
      child: Stack(
        children: <Widget>[
          NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: buildGoodsSwiper(),
                  ),
                  buildSliverToBoxAdapterOne(),
                  buildSliverToBoxAdapterTwo(),
                  buildSliverToBoxAdapterThree(),
                  buildSliverToBoxAdapterFour(),
                  buildSliverToBoxAdapterFive(),
                  buildSliverToBoxAdapterSix(),
                  buildSliverToBoxAdapterPlaceholder(),
                  buildSliverToBoxAdapterShop(),
                  buildSliverToBoxAdapterPlaceholder(),
                ];
              },
              body: buildGoodsDetailImaegs()),
          buildOpacityAppbar(),
          // 返回顶部按钮
          _showToTopButton
              ? Positioned(
                  bottom: 80,
                  right: 12,
                  child: InkWell(
                    onTap: () {
                      _scrollController!.animateTo(0, duration: Duration(milliseconds: 600), curve: Curves.ease);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(35)), border: Border.all(width: .5, color: Colors.black26.withOpacity(.2))),
                      child: Icon(
                        Icons.vertical_align_top,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : Container(),

          //底部操作栏
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              width: Get.width,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(onPressed: Get.back, icon: Icon(Icons.home)),
                  Expanded(
                    child: WaterfallFlow.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                      children: <Widget>[
                        OutlinedButton(
                            onPressed: () async {
                              if (couponLinkResult != null) {
                                utils.copy(couponLinkResult!.longTpwd ?? '无优惠券', message: '复制成功,打开淘宝APP领取优惠券');
                              }
                            },
                            child: Text('复制口令')),
                        ElevatedButton(
                            onPressed: () async {
                              if (couponLinkResult != null) {
                                await utils.openTaobao(couponLinkResult!.couponClickUrl ?? 'https://itbug.shop');
                              }
                            },
                            child: Text('立即领券')),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 详情图
  Widget buildGoodsDetailImaegs() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            alignment: Alignment.topLeft,
            child: Text(
              '宝贝详情',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          buildImagesWidget()
        ],
      ),
    );
  }

  // 店铺信息
  Widget buildSliverToBoxAdapterShop({bool isSliver = true}) {
    var widget = containerWarp(Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 500,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      (_shopInfo != null && _shopInfo!.pictUrl != null ? NetworkImage(MImageUtils.magesProcessor(_shopInfo!.pictUrl!)) : AssetImage('assets/images/ava.png')) as ImageProvider<Object>?,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  _shopInfo != null ? _shopInfo!.sellerNick! : '店铺名初始化',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Container(
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FButton(
                  text: '进店逛逛',
                  color: Colors.white,
                  padding: EdgeInsets.all(12),
                  onPressed: () {},
                  clickEffect: true,
                  strokeColor: Color.fromRGBO(254, 55, 56, 1),
                  strokeWidth: 1,
                  highlightColor: Colors.grey.shade100,
                ),
                SizedBox(
                  width: 12,
                ),
                FButton(
                  text: '全部商品',
                  color: Color.fromRGBO(254, 55, 56, 1),
                  padding: EdgeInsets.all(12),
                  onPressed: () {},
                  clickEffect: true,
                  strokeWidth: 1,
                  highlightColor: Colors.grey.shade100,
                ),
              ],
            ),
          )
        ],
      ),
    ));
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: _shopInfo != null ? widget : Container(),
    );
  }

  // 占位
  Widget buildSliverToBoxAdapterPlaceholder({bool isSliver = true}) {
    Widget widget = Container(
      color: Color.fromRGBO(246, 245, 245, 1.0),
      height: 12,
    );
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: Container(
        color: Color.fromRGBO(246, 245, 245, 1.0),
        height: 12,
      ),
    );
  }

  // 第六行,推荐语
  Widget buildSliverToBoxAdapterSix({bool isSliver = true}) {
    var widget = containerWarp(
        Container(
          alignment: Alignment.topLeft,
          child: FSuper(
            lightOrientation: controller.FLightOrientation.LeftBottom,
            textAlign: TextAlign.start,
            spans: [
              TextSpan(text: '推荐理由: ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '${info.desc}', style: TextStyle(color: Colors.grey)),
              TextSpan(
                  text: '复制文案',
                  style: TextStyle(color: Colors.pinkAccent),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      utils.copy(info.desc);
                    })
            ],
          ),
        ),
        height: 12);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第五行,领券
  Widget buildSliverToBoxAdapterFive({bool isSliver = true}) {
    var widget = containerWarp(
        InkWell(
          onTap: () async {
            if (couponLinkResult != null) {
              await utils.openTaobao(couponLinkResult!.couponClickUrl ?? 'https://itbug.shop');
            }
          },
          child: Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(color: Color.fromRGBO(252, 54, 74, 1.0), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Color.fromRGBO(255, 237, 199, 1.0), borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '${info.couponPrice}元优惠券'.replaceAll('.0', ''),
                                style: TextStyle(color: Color.fromRGBO(145, 77, 9, 1.0), fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              child: Text(
                                '使用日期:${getTimeStr(info.couponStartTime ?? '')} - ${getTimeStr(info.couponEndTime ?? '已过期')}',
                                style: TextStyle(color: Color.fromRGBO(145, 77, 9, 1.0), fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      // 圆
                      Positioned(
                        left: -6,
                        top: 38,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(252, 54, 74, 1.0)),
                        ),
                      ),
                      Positioned(
                        right: -6,
                        top: 38,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(252, 54, 74, 1.0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '立即领券 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
        height: 12);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第四行,满减
  Widget buildSliverToBoxAdapterFour({bool isSliver = true}) {
    var widget = containerWarp(Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: Text(
              '满减',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                FSuper(
                  lightOrientation: controller.FLightOrientation.LeftBottom,
                  text: '满${info.couponConditions}减${info.couponPrice}',
                  backgroundColor: Colors.red,
                  textAlign: TextAlign.center,
                  textAlignment: Alignment.center,
                  style: TextStyle(color: Colors.white),
                  corner: controller.FCorner.all(4),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                ),
                // Text(
                //   ' 活动已过期',
                //   style: TextStyle(
                //       color: Colors.red,
                //       fontSize: ScreenUtil().setSp(45),
                //       fontWeight: FontWeight.bold),
                // )
              ],
            ),
          )
        ],
      ),
    ));
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(child: widget);
  }

  // 第三行,标题
  Widget buildSliverToBoxAdapterThree({bool isSliver = true}) {
    var widget = containerWarp(
        Container(
          width: Get.width,
          child: DrawableStartText(
            lettersCountOfAfterImage: info.dtitle!.length,
            assetImage: info.shopType == 1 ? 'assets/icons/tianmao2.png' : 'assets/icons/taobao2.png',
            text: ' ${info.title}',
            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        height: 20);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第二行,原价+销量
  Widget buildSliverToBoxAdapterTwo({bool isSliver = true}) {
    var widget = containerWarp(Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FSuper(
            lightOrientation: controller.FLightOrientation.LeftBottom,
            spans: <TextSpan>[TextSpan(text: '原价 ¥ ${info.originalPrice}', style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough))],
          ),
          FSuper(
            lightOrientation: controller.FLightOrientation.LeftBottom,
            text: '已售 ${info.monthSales}',
          )
        ],
      ),
    ));
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第一行,券后价+返佣
  Widget buildSliverToBoxAdapterOne({bool isSliver = true}) {
    var widget = containerWarp(
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SimplePrice(
              price: '${info.actualPrice} ',
              zhe: '${info.discounts}',
            ),
          ],
        ),
      ),
      height: 10,
    );
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  Widget containerWarp(Widget child, {double height = 0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: height),
      child: child,
    );
  }

  // 轮播
  Widget buildGoodsSwiper() {
    var swiper = Swiper(
      key: _swaperGlogbalKey,
      autoplay: getImages().isNotEmpty,
      duration: 1000,
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return ExtendedImageWidget(
          width: Get.width,
          height: Get.width,
          src: getImages()[index],
          fit: BoxFit.fill,
          knowSize: true,
        );
      },
      onIndexChanged: (index) {
        setState(() {
          curentSwaiperIndex = index;
        });
      },
      itemCount: getImages().length,
    );

    return Stack(
      children: <Widget>[
        buildContainer(swiper: swiper),
        Positioned(
          left: 12,
          top: 12 + ztlHei,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.black26.withOpacity(.3),
              child: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: Container(
            decoration: BoxDecoration(color: Colors.black26.withOpacity(.3), borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              '${curentSwaiperIndex + 1} / ${getImages().length}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  // 顶部显影appbar
  Opacity buildOpacityAppbar() {
    return Opacity(
      opacity: _appbarOpaction,
      child: Container(
        key: _appbarGlogbalKey,
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        height: kToolbarHeight,
        width: Get.width,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26)]),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
              color: Colors.black,
              onPressed: Get.back,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: TabBar(
                indicator: RoundUnderlineTabIndicator(
                    insets: EdgeInsets.only(bottom: 3),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    )),
                labelColor: Colors.black,
                tabs: [
                  Tab(text: '宝贝'),
                  Tab(text: '详情'),
                  Tab(text: '推荐'),
                ],
                controller: _tabController,
                onTap: tabOnChange,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer({Widget? swiper, double? width}) {
    return Container(
      height: width ?? Get.width,
      margin: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      child: swiper,
    );
  }

  // 商品详情图
  SingleChildScrollView buildImagesWidget() {
    return SingleChildScrollView(
      key: _detailImagesGlogbalKey,
      child: DetailImagesWidget(
        images: info.detailPics,
        hideTitle: true,
      ),
    );
  }

  String getTimeStr(String time) {
    return DateUtil.formatDateStr(time, format: DateFormats.y_mo_d);
  }

  List<String> getImages() {
    var str = info.imgs ?? '';
    return str.split(',');
  }

  String getCatName(String fqcat) {
    var cats = <String>['女装', '男装', '内衣', '美妆', '配饰', '鞋品', '箱包', '儿童', '母婴', '居家', '美食', '数码', '家电', '其他', '车品', '文体', '宠物'];
    return cats[int.parse(fqcat) - 1];
  }

  Future<String> initDatas() async {
    final result = await DdTaokeSdk.instance.getDetailBaseData(
      productId: widget.goodsId,
    );
    if (result != null) {
      if (mounted) {
        setState(() {
          info = result.info!;
          couponLinkResult = result.couponInfo;
        });
      }
    } else {
      throw Exception('商品优惠已过期');
    }
    return 'success';
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController!.dispose();
  }

  // 获取widget距离顶部的位置
  double getY(BuildContext buildContext) {
    final box = buildContext.findRenderObject() as RenderBox;
    //final size = box.size;
    final topLeftPosition = box.localToGlobal(Offset.zero);
    return topLeftPosition.dy;
  }
}
