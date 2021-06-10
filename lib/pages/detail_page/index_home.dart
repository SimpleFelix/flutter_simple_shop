import 'package:common_utils/common_utils.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/detail_base_data.dart';
import 'package:demo1/constant/color.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:url_launcher/url_launcher.dart';

//小部件
import './swiper_widget.dart';
import '../../widgets/coupon_price.dart';
import '../../widgets/title_widget.dart';
import '../../widgets/icon_block_widget.dart';
import './detail_imgs_widget.dart';
import './shop_info_widget.dart';
import './action_buttons.dart';
import '../../widgets/no_data.dart';

class DetailIndex extends StatefulWidget {
  final String goodsId;

  DetailIndex({required this.goodsId});

  @override
  _DetailIndexState createState() => _DetailIndexState();
}

class _DetailIndexState extends State<DetailIndex> {
  // 商品数据
  DetailBaseDataResult? detail;

  bool loadIng = true;

  @override
  Widget build(BuildContext context) {
    if (loadIng) {
      return Scaffold(
        appBar: _appBarWidget(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (detail == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBarWidget(),
        body: NoDataWidget(),
      );
    }
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            appBar: null,
            body: Stack(
              children: <Widget>[
                Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          // 轮播图
                          _imgSwiper(detail!.info!.imgs),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          // 标题
                          TitleWidget(
                            title: detail!.info!.dtitle,
                            size: 60,
                            color: Colors.black,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          // 价钱行
                          Container(
                            padding:
                                EdgeInsets.only(left: 20, top: 5, bottom: 5),
                            child: CouponPriceWidget(
                              actualPrice: detail!.info!.actualPrice
                                  .toString(),
                              originalPrice:
                                  detail!.info!.originalPrice,
                              couponPriceFontSize: 100,
                              originalPriceFontSize: 55,
                              interval: 15.0,
                              showDiscount: true,
                            ),
                          ),

                          //信息展示
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                      "月销:${detail!.info!.monthSales}",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                Container(
                                  child: Text(
                                      "两小时销量:${detail!.info!.twoHoursSales}",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                Container(
                                  child: Text(
                                      "当天销量:${detail!.info!.dailySales}",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: ScreenUtil().setHeight(40)),
                          // 返利说明
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            color: Color.fromRGBO(251, 242, 245, 1.0),
                            height: ScreenUtil().setHeight(150),
                            child: Row(
                              children: <Widget>[
                                // 左边文字
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset("assets/icons/youhuiquan.png",
                                          width: ScreenUtil().setWidth(78),
                                          height: ScreenUtil().setHeight(78)),
                                      Container(
                                        child: Text(
                                            "该商品可领取满${detail!.info!.couponConditions}"
                                            "减${NumUtil.getNumByValueDouble(detail!.info!.couponPrice, 0).toString()}红包"),
                                      ),
                                      Icon(Icons.help_outline,
                                          color: Colors.black26,
                                          size: ScreenUtil().setSp(70))
                                    ],
                                  ),
                                ),
                                //右边
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "券金额:${NumUtil.getNumByValueDouble(detail!.info!.couponPrice, 0).toString()}",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // 返利说明END--------------------

                          //有效期
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: ScreenUtil().setHeight(150),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "活动剩余",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(_calcHowLong()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //有效期END-------------------

                          //领券
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: ScreenUtil().setHeight(150),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "优惠券",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "立即领取",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Container(
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //领券END--------------------

                          // 促销活动
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: ScreenUtil().setHeight(150),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "促销活动",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _activityTypeStr(),
                                      style: TextStyle(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // 促销活动END----------------------

                          // 服务
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: ScreenUtil().setHeight(150),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "服务",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          _isFreeshipRemoteDistrict(),
                                          // 是否包邮
                                          _haveYunfeixian()
                                          // 是否赠送运费险
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                          // 服务END----------------------

                          // 推荐理由
                          IconBlockWidget(
                            desc: detail!.info!.desc,
                          ),
                          Container(
                            height: 10.0,
                            color: Color.fromRGBO(245, 245, 249, 1.0),
                          ),
                          // 商铺信息
                          ShopInfoWidget(goodsInfo: detail!.info!),
                          Container(
                            height: 10.0,
                            color: Color.fromRGBO(245, 245, 249, 1.0),
                          ),

                          // 详情图
                          DetailImagesWidget(
                              images: detail!.info!.detailPics),
                        ],
                      ),
                    )),
                //底部操作按钮
                ActionButtons(
                  goodsId: detail!.info!.goodsId,
                  getCallBack: () {
                    _gotoGetCouperLink();
                  },
                )
              ],
            )));
  }

  void _gotoGetCouperLink() async {
    if (detail != null) {
      var url = detail!.couponInfo!.couponClickUrl!;
      var tburl = "taobao://${url.substring(8)}";
      if (await canLaunch(tburl)) {
        await launch(tburl);
      } else {
        launch(url);
      }
    }
  }

  //商品是否包邮
  Widget _isFreeshipRemoteDistrict() {
    return FSuper(
      lightOrientation: FLightOrientation.LeftBottom,
      text: '包邮',
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(right: 5),
//      corner: Corner.all(3),
//      strokeColor: Colors.black,
      strokeWidth: 1,
    );
  }

  //商品是否赠送运费险
  Widget _haveYunfeixian() {
    int? yfx = detail!.info!.yunfeixian;
    if (yfx == 1) {
      return FSuper(
        lightOrientation: FLightOrientation.LeftBottom,
        text: '赠送运费险',
        padding: EdgeInsets.all(2),
//        corner: Corner.all(3),
//        strokeColor: Colors.black,
        strokeWidth: 1,
      );
    }
    return Container();
  }

  // 判断商品参加啥活动
  String _activityTypeStr() {
    int? activityType = detail!.info!.activityType;
    String str = "该商品正在参加满减活动";
    if (activityType == 2) {
      str = "该商品正在参加淘抢购活动";
    }
    if (activityType == 3) {
      str = "该商品正在参加聚划算活动";
    }
    return str;
  }

  // 计算有效期
  String _calcHowLong() {
    DateTime now = DateTime.now();
    final endTime = detail!.info!.couponEndTime!;
    var difference = DateUtil.getDateTime(endTime)!.difference(now);
    var str =
        "${difference.inDays}天${difference.inHours % 24}小时${difference.inMinutes % 60}分";
    return str;
  }

  Widget _imgSwiper(String? images) {
    if (images != null && images != "") {
      return SwiperWidget(
          images: images);
    }
    return Container();
  }

  // appBar
  AppBar _appBarWidget() {
    return AppBar(
      title: Text("详情"),
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final result = await DdTaokeSdk.instance
          .getDetailBaseData(productId: widget.goodsId);
      if (mounted) {
        setState(() {
          detail = result;
          loadIng = false;
        });
      }
    });
  }
}
