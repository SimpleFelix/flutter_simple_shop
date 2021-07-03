import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/coupon_link_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:demo1/widgets/loading_widget.dart';
import 'package:demo1/widgets/simple_price.dart';
import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';

import '../../../common/utils.dart';
import '../../../modals/shop_info.dart';
import '../../../util/image_util.dart';
import '../../../widgets/RoundUnderlineTabIndicator.dart';
import '../../../widgets/extended_image.dart';
import '../../../widgets/my_drawable_start_text.dart';
import '../detail_imgs_widget.dart';
import 'model/hdk_detail.dart';

class HaoDanKuDetailItem extends StatefulWidget {
  final String goodsId;

  HaoDanKuDetailItem({required this.goodsId});

  @override
  _HaoDanKuDetailItemState createState() => _HaoDanKuDetailItemState();
}

class _HaoDanKuDetailItemState extends State<HaoDanKuDetailItem> with TickerProviderStateMixin {
  late Product info;
  CouponLinkResult? couponLinkResult;
  List<Video>? videos = [];
  ShopInfo? _shopInfo;
  var futureBuildData;
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
    // TODO: implement didChangeDependencies
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: FutureBuilder(
        future: futureBuildData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return buildCustomScrollViewShop();
          }
          return LoadingWidget();
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
                  bottom: ScreenUtil().setHeight(390),
                  right: ScreenUtil().setWidth(70),
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
            bottom: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(0)),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
              width: ScreenUtil().setWidth(1440),
              height: ScreenUtil().setHeight(250),
              child: Row(
                children: <Widget>[
                  Container(
                      height: ScreenUtil().setHeight(150),
                      width: ScreenUtil().setWidth(620),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  size: ScreenUtil().setSp(50),
                                ),
                                Text(
                                  '首页',
                                  style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  size: ScreenUtil().setSp(50),
                                ),
                                Text(
                                  '分享',
                                  style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.local_pharmacy,
                                  size: ScreenUtil().setSp(50),
                                ),
                                Text(
                                  '收藏',
                                  style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: ScreenUtil().setWidth(820),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FSuper(
                          lightOrientation: FLightOrientation.LeftBottom,
                          height: ScreenUtil().setHeight(150),
                          width: ScreenUtil().setWidth(335),
                          text: '复制口令',
                          corner: FCorner.all(50),
                          textAlignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
                          gradient: LinearGradient(colors: [
                            Colors.redAccent,
                            Color(0xfffcad2c),
                          ]),
                          onClick: () async {
                            if (couponLinkResult != null) {
                              utils.copy(couponLinkResult!.longTpwd ?? '无优惠券');
                            }
                          },
                        ),
                        FSuper(
                          lightOrientation: FLightOrientation.LeftBottom,
                          height: ScreenUtil().setHeight(150),
                          width: ScreenUtil().setWidth(335),
                          text: '立即领券',
                          corner: FCorner.all(50),
                          textAlignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
                          gradient: LinearGradient(colors: [
                            Colors.pinkAccent,
                            Color(0xfffcad2c),
                          ]),
                          onClick: () async {
                            if (couponLinkResult != null) {
                              await utils.openTaobao(couponLinkResult!.couponClickUrl ?? 'https://itbug.shop');
                            }
                          },
                        ),
                      ],
                    ),
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
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(50), horizontal: ScreenUtil().setWidth(50)),
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
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(670),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      (_shopInfo != null && _shopInfo!.pictUrl != null ? NetworkImage(MImageUtils.magesProcessor(_shopInfo!.pictUrl!)) : AssetImage('assets/images/ava.png')) as ImageProvider<Object>?,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
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
            width: ScreenUtil().setWidth(670),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FButton(
                  text: '进店逛逛',
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                  onPressed: () {},
                  clickEffect: true,
                  strokeColor: Color.fromRGBO(254, 55, 56, 1),
                  strokeWidth: 1,
                  highlightColor: Colors.grey.shade100,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                FButton(
                  text: '全部商品',
                  color: Color.fromRGBO(254, 55, 56, 1),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
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

  // 轮播图阴影
  Positioned buildPositionedYy() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        height: ScreenUtil().setHeight(400),
        width: ScreenUtil().setWidth(1440),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
          Colors.grey[700]!.withOpacity(.2),
          Colors.grey.withOpacity(.0),
        ])),
      ),
    );
  }

  // 占位
  Widget buildSliverToBoxAdapterPlaceholder({bool isSliver = true}) {
    Widget widget = Container(
      color: Color.fromRGBO(246, 245, 245, 1.0),
      height: ScreenUtil().setHeight(50),
    );
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: Container(
        color: Color.fromRGBO(246, 245, 245, 1.0),
        height: ScreenUtil().setHeight(50),
      ),
    );
  }

  // 第六行,推荐语
  Widget buildSliverToBoxAdapterSix({bool isSliver = true}) {
    var widget = containerWarp(
        Container(
          alignment: Alignment.topLeft,
          child: FSuper(
            lightOrientation: FLightOrientation.LeftBottom,
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
        height: 30);
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
            height: ScreenUtil().setHeight(300),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30), vertical: ScreenUtil().setHeight(20)),
            decoration: BoxDecoration(color: Color.fromRGBO(252, 54, 74, 1.0), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(260),
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(30)),
                      decoration: BoxDecoration(color: Color.fromRGBO(255, 237, 199, 1.0), borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${info.couponPrice}元优惠券',
                              style: TextStyle(color: Color.fromRGBO(145, 77, 9, 1.0), fontSize: ScreenUtil().setSp(60), fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
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
                      left: ScreenUtil().setWidth(-25),
                      top: ScreenUtil().setHeight(105),
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(252, 54, 74, 1.0)),
                      ),
                    ),
                    Positioned(
                      right: ScreenUtil().setWidth(-25),
                      top: ScreenUtil().setHeight(105),
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(252, 54, 74, 1.0)),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
                    child: Text(
                      '立即领券 >',
                      style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(50)),
                    ),
                  ),
                )
              ],
            ),
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

  // 第四行,满减
  Widget buildSliverToBoxAdapterFour({bool isSliver = true}) {
    var widget = containerWarp(Container(
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(250),
            child: Text(
              '满减',
              style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(45)),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                FSuper(
                  lightOrientation: FLightOrientation.LeftBottom,
                  text: '满${info.couponConditions}减${info.couponPrice}',
                  backgroundColor: Colors.red,
                  textAlign: TextAlign.center,
                  textAlignment: Alignment.center,
                  style: TextStyle(color: Colors.white),
                  corner: FCorner.all(4),
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(5)),
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
          width: ScreenUtil().setWidth(1440),
          child: DrawableStartText(
            lettersCountOfAfterImage: info.dtitle!.length,
            assetImage: info.shopType == 1 ? 'assets/icons/tianmao2.png' : 'assets/icons/taobao2.png',
            text: ' ${info.title}',
            textStyle: TextStyle(fontSize: ScreenUtil().setSp(50), fontWeight: FontWeight.w400),
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
    var widget = containerWarp(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FSuper(
                lightOrientation: FLightOrientation.LeftBottom,
                spans: <TextSpan>[TextSpan(text: '原价 ¥ ${info.originalPrice}', style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough))],
              ),
              FSuper(
                lightOrientation: FLightOrientation.LeftBottom,
                text: '已售 ${info.monthSales}',
              )
            ],
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

  // 第一行,券后价+返佣
  Widget buildSliverToBoxAdapterOne({bool isSliver = true}) {
    var widget = containerWarp(
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SimplePrice(price:'${info.actualPrice} ',zhe: '${info.discounts}',),

            // 预计可得
            // FSuper(
            //   lightOrientation: FLightOrientation.LeftBottom,
            //   text: '预计收益 ¥0',
            //   backgroundColor: Colors.pinkAccent.withOpacity(0.1),
            //   shadowBlur: 4,
            //   padding: EdgeInsets.symmetric(
            //       horizontal: ScreenUtil().setWidth(10),
            //       vertical: ScreenUtil().setHeight(5)),
            // ),
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
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(height)),
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
        buildPositionedYy(),
        Positioned(
          left: ScreenUtil().setWidth(50),
          top: ScreenUtil().setHeight(50) + ztlHei,
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
          right: ScreenUtil().setWidth(50),
          bottom: ScreenUtil().setHeight(50),
          child: Container(
            decoration: BoxDecoration(color: Colors.black26.withOpacity(.3), borderRadius: BorderRadius.all(Radius.circular(15))),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30), vertical: ScreenUtil().setHeight(20)),
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
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        margin: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        height: ScreenUtil().setHeight(200),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26)]),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: ScreenUtil().setWidth(300),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
              ),
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
            Container(
              width: ScreenUtil().setWidth(300),
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

  Container buildContainer({Widget? swiper}) {
    return Container(
      height: ScreenUtil().setHeight(1340),
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
    final result = await DdTaokeSdk.instance.getDetailBaseData(productId: widget.goodsId);
    if (result != null) {
      if (mounted) {
        setState(() {
          info = result.info!;
          couponLinkResult = result.couponInfo;
        });
      }
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
