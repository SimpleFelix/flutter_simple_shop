import 'package:common_utils/common_utils.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';

import './action_buttons.dart';
import './detail_imgs_widget.dart';

//小部件
import './swiper_widget.dart';
import '../../constant/color.dart';
import '../../service/api_service.dart';
import '../../widgets/coupon_price.dart';
import '../../widgets/icon_block_widget.dart';
import '../../widgets/no_data.dart';
import '../../widgets/title_widget.dart';
import '../dynamic/model/wph_detail_resul.dart';

class DetailIndex extends StatefulWidget {
  final String weipinhuiId;

  DetailIndex({required this.weipinhuiId});

  @override
  _DetailIndexState createState() => _DetailIndexState();
}

class _DetailIndexState extends State<DetailIndex> {
  bool loadIng = true;

  // 唯品会商品数据
  WeipinhuiDetail? weipinhuiDetail;

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

    if (weipinhuiDetail == null) {
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
                          _imgSwiper(),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          // 标题
                          TitleWidget(
                            title: detail.goodsName,
                            size: 60,
                            color: Colors.black,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          // 价钱行
                          Container(
                            padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                            child: CouponPriceWidget(
                              actualPrice: detail.vipPrice,
                              originalPrice: double.parse(detail.marketPrice),
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
                                  child: Text('月销:', style: TextStyle(color: Colors.grey)),
                                ),
                                Container(
                                  child: Text('两小时销量:', style: TextStyle(color: Colors.grey)),
                                ),
                                Container(
                                  child: Text('当天销量:', style: TextStyle(color: Colors.grey)),
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
                                      Image.asset('assets/icons/youhuiquan.png', width: ScreenUtil().setWidth(78), height: ScreenUtil().setHeight(78)),
                                      Container(
                                        child: Text('该商品可领取满'
                                            '减红包'),
                                      ),
                                      Icon(Icons.help_outline, color: Colors.black26, size: ScreenUtil().setSp(70))
                                    ],
                                  ),
                                ),
                                //右边
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    '券金额:${NumUtil.getNumByValueDouble(double.parse(detail.vipPrice), 0).toString()}',
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
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '活动剩余',
                                    style: TextStyle(color: Colors.grey),
                                  ),
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
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '优惠券',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '立即领取',
                                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
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
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '促销活动',
                                    style: TextStyle(color: Colors.grey),
                                  ),
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
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(300),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '服务',
                                    style: TextStyle(color: Colors.grey),
                                  ),
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
                            desc: detail.categoryName,
                          ),
                          Container(
                            height: 10.0,
                            color: Color.fromRGBO(245, 245, 249, 1.0),
                          ),
                          // 商铺信息
                          // ShopInfoWidget(goodsInfo: detail.info!),
                          Container(
                            height: 10.0,
                            color: Color.fromRGBO(245, 245, 249, 1.0),
                          ),

                          // 详情图
                          DetailImagesWidget(images: ''),
                        ],
                      ),
                    )),
                //底部操作按钮
                ActionButtons(
                  goodsId: detail.goodsId,
                  getCallBack: () {
                    _gotoGetCouperLink();
                  },
                )
              ],
            )));
  }

  void _gotoGetCouperLink() async {}

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
    return FSuper(
      lightOrientation: FLightOrientation.LeftBottom,
      text: '赠送运费险',
      padding: EdgeInsets.all(2),
      strokeWidth: 1,
    );
  }

  // 判断商品参加啥活动
  String _activityTypeStr() {
    var str = '该商品正在参加满减活动';
    return str;
  }

  // 计算有效期
  String _calcHowLong() {
    var now = DateTime.now();
    final endTime = detail.schemeEndTime;
    var difference = DateUtil.getDateTime(DateUtil.formatDateMs(endTime))!.difference(now);
    var str = '${difference.inDays}天${difference.inHours % 24}小时${difference.inMinutes % 60}分';
    return str;
  }

  WeipinhuiDetail get detail => weipinhuiDetail!;

  Widget _imgSwiper() {
    if (weipinhuiDetail != null) {
      return SwiperWidget(images: weipinhuiDetail!.goodsMainPicture);
    }
    return Container();
  }

  // appBar
  AppBar _appBarWidget() {
    return AppBar(
      title: Text('详情'),
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
      final result = await tkApi.getWphProductInfo(widget.weipinhuiId);
      setState(() {
        weipinhuiDetail = result;
        loadIng = false;
      });
    });
  }
}
