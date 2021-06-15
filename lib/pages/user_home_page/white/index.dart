import 'dart:convert';
import 'dart:math';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as su;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/utils.dart';
import 'my_special_text_span_builder.dart';
import 'components/more_action_bottomsheet.dart';
import 'components/search_goods.dart';

// 发布页面
class WhiteIndex extends StatefulWidget {
  @override
  _WhiteIndexState createState() => _WhiteIndexState();
}

class _WhiteIndexState extends State<WhiteIndex> {
  final MySpecialTextSpanBuilder _mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey _key = GlobalKey();

  final FocusNode _focusNode = FocusNode();
  double _keyboardHeight = 267.0;

  bool get showCustomKeyBoard =>
      activeEmojiGird || activeAtGrid || activeDollarGrid || activeImageGrid;
  bool activeEmojiGird = false;
  bool activeAtGrid = false;
  bool activeDollarGrid = false;
  bool activeImageGrid = false;
  bool showEmojiPanel = false;

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardHeight > 0) {
      activeEmojiGird =
          activeAtGrid = activeDollarGrid = activeImageGrid = false;
    }

    _keyboardHeight = max(_keyboardHeight, keyboardHeight);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('发布动态', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: buildSvgPictureIcon('assets/svg/fabu.svg', 100),
          )
        ],
      ),
      body: Container(
        height: Get.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: su.ScreenUtil().setWidth(70)),
                child: ExtendedTextField(
                  key: _key,
                  autofocus: false,
                  expands: true,
                  cursorColor: Colors.pinkAccent,
                  controller: _textEditingController,
                  specialTextSpanBuilder: MySpecialTextSpanBuilder(
                    showAtBackground: false,
                    goodsCardOnTapCallBack: deleteOneGoodsCard,
                  ),
                  focusNode: _focusNode,
                  maxLines: null,
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  onTap: () {
                    if (showEmojiPanel == true) {
                      setState(() {
                        showEmojiPanel = false;
                      });
                    }
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  //textDirection: TextDirection.rtl,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                buildActionIcons(),
                showEmojiPanel
                    ? Container(
                        height: _keyboardHeight,
                        child: _emoJiList(),
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// 底部工具栏
  Container buildActionIcons() {
    return Container(
      height: kToolbarHeight,
      width: Get.width,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildSvgPictureIcon('assets/svg/biaoqing.svg', 80, onTap: () {
            if (showEmojiPanel) {
              setState(() {
                showEmojiPanel = false;
              });
            } else {
              setState(() {
                showEmojiPanel = true;
              });
            }
          }),
          buildSvgPictureIcon('assets/svg/tupian.svg', 80, onTap: () async {
            final file = await utils.selectFile();
            if (file != null) {
              print('用户选择了图片,路径为:${file.path}');
              insertText(
                  "<img src='https://static.saintic.com/picbed/huang/2021/06/12/1623466301058.jpg' width='${Get.width}' height='${Get.width}'/>");
              insertText('\n');
              insertText('\n');
              insertText('如果您觉得这个开源项目不错,扫码支持一下哦~');
            }
          }),
          buildSvgPictureIcon('assets/svg/at.svg', 80),
          buildSvgPictureIcon('assets/svg/jinhao.svg', 80, onTap: () {
            utils.showMessage('功能设计中');
          }),
          buildSvgPictureIcon('assets/svg/shangpin.svg', 80, onTap: () async {
            await Get.to(() => SearchProduct());
            insertText('\n');
            insertText(
                '[goodsId={\"time\":1590725795309,\"code\":0,\"msg\":\"成功\",\"data\":{\"id\":26650005,\"goodsId\":\"611071580085\",\"title\":\"蒲公英舒肝养护口臭毒排去清肝火旺盛熬夜玉米须菊花决明子葛根茶\",\"dtitle\":\"十五味古方养护一体益甘茶\",\"originalPrice\":53.90,\"actualPrice\":13.90,\"shopType\":1,\"goldSellers\":0,\"monthSales\":261,\"twoHoursSales\":0,\"dailySales\":0,\"commissionType\":3,\"desc\":\"【买2送1，买3送3】养生堂旗舰店专注健康，决明子，枸杞子，菊花，金银花，桂花，牛蒡根6种原料科学配比，独立茶袋，清热去火，呵护心肝，拒绝熬夜爆痘，告别眼睛酸涩【赠运费险】\",\"couponReceiveNum\":2,\"couponLink\":\"https://uland.taobao.com/quan/detail?sellerId=3184321095&activityId=dd37e655092b4fab99da7b5c497b5b68\",\"couponEndTime\":\"2020-05-31 23:59:59\",\"couponStartTime\":\"2020-05-29 00:00:00\",\"couponPrice\":40.00,\"couponConditions\":\"53\",\"activityType\":1,\"createTime\":\"2020-05-28 16:18:07\",\"mainPic\":\"https://static.saintic.com/picbed/huang/2021/06/12/1623466301058.jpg\",\"marketingMainPic\":\"https://sr.ffquan.cn/dtk_user_fd/20200528/br7n7baulrgabsn9gs6g0.jpg\",\"sellerId\":\"3184321095\",\"cid\":6,\"discounts\":0.26,\"commissionRate\":40.00,\"couponTotalNum\":100000,\"haitao\":0,\"activityStartTime\":\"\",\"activityEndTime\":\"\",\"shopName\":\"养庆堂旗舰店\",\"shopLevel\":16,\"descScore\":4.8,\"brand\":0,\"brandId\":1669201481,\"brandName\":\"养庆堂\",\"hotPush\":0,\"teamName\":\"鼎盛科技\",\"itemLink\":\"https://detail.tmall.com/item.htm?id=611071580085\",\"tchaoshi\":0,\"detailPics\":\"//img.alicdn.com/imgextra/i4/3184321095/O1CN018ZrR7f1JxYIGcHwjH_!!3184321095.jpg,//img.alicdn.com/imgextra/i4/3184321095/O1CN014VTJ3K1JxYHQVVRmq_!!3184321095.jpg,//img.alicdn.com/imgextra/i2/3184321095/O1CN01hVR0WB1JxYI6DkAMI_!!3184321095.jpg,//img.alicdn.com/imgextra/i4/3184321095/O1CN01v5jbSd1JxYHUI85FT_!!3184321095.jpg,//img.alicdn.com/imgextra/i4/3184321095/O1CN01SW5Gwh1JxYHQ0YkAJ_!!3184321095.jpg,//img.alicdn.com/imgextra/i1/3184321095/O1CN015MLkAp1JxYHIFebAv_!!3184321095.jpg,//img.alicdn.com/imgextra/i3/3184321095/O1CN01jqi5rS1JxYHQ0YsTj_!!3184321095.jpg,//img.alicdn.com/imgextra/i3/3184321095/O1CN01TFcC9B1JxYIEdR8EQ_!!3184321095.jpg,//img.alicdn.com/imgextra/i1/3184321095/O1CN01nOjjTF1JxYHMvBrbM_!!3184321095.jpg,//img.alicdn.com/imgextra/i3/3184321095/O1CN01EwWQ0P1JxYHT4FAAV_!!3184321095.jpg,//img.alicdn.com/imgextra/i1/3184321095/O1CN01ZC6KZ21JxYHQVXG4T_!!3184321095.jpg,//img.alicdn.com/imgextra/i2/3184321095/O1CN01RPMSIx1JxYHQVVBAl_!!3184321095.jpg,//img.alicdn.com/imgextra/i4/3184321095/O1CN01tVX03j1JxYHRPwy2z_!!3184321095.jpg,//img.alicdn.com/imgextra/i3/3184321095/O1CN01DfWVGJ1JxYHQYjFAM_!!3184321095.jpg,//img.alicdn.com/imgextra/i4/3184321095/O1CN01ifzxN81JxYHQ0Z4xh_!!3184321095.jpg,//img.alicdn.com/imgextra/i2/3184321095/O1CN01oY70Zs1JxYHT4EYku_!!3184321095.jpg\",\"dsrScore\":4.80,\"dsrPercent\":28.57,\"shipScore\":4.80,\"shipPercent\":23.10,\"serviceScore\":4.80,\"servicePercent\":22.35,\"subcid\":[],\"imgs\":\"https://img.alicdn.com/imgextra/i1/3184321095/O1CN01uHD1Cj1JxYHMpTzXQ_!!0-item_pic.jpg,https://img.alicdn.com/imgextra/i3/3184321095/O1CN01d0QSFG1JxYH67Zu8H_!!3184321095.jpg,https://img.alicdn.com/imgextra/i2/3184321095/O1CN01LoOz4q1JxYH8jfXbt_!!3184321095.jpg,https://img.alicdn.com/imgextra/i1/3184321095/O1CN01ivu0q81JxYH9wHe2j_!!3184321095.jpg,https://img.alicdn.com/imgextra/i1/3184321095/O1CN01jqssqw1JxYHAaCMJP_!!3184321095.jpg\",\"reimgs\":\"\",\"quanMLink\":0,\"hzQuanOver\":0,\"yunfeixian\":1,\"estimateAmount\":-1,\"shopLogo\":\"https://img.alicdn.com/imgextra//39/69/TB1.7_sSpXXXXXnapXXSutbFXXX.jpg\",\"tbcid\":50010420}}End]');
            insertText('\n');
            utils.showMessage('插入商品成功');
          }),
          buildSvgPictureIcon('assets/svg/gengduo.svg', 80, onTap: () {
            MoreActions.show([
              ListTile(
                title: Text('添加标题'),
                onTap: () {},
                leading: Icon(Icons.title),
              ),
              ListTile(
                title: Text('添加标签'),
                onTap: () {},
                leading: Icon(Icons.tag),
              ),
            ]);
          }),
          buildSvgPictureIcon('assets/svg/jianpan.svg', 80, onTap: () {
            if (_focusNode.hasFocus) {
//              FocusScope.of(context).requestFocus(FocusNode());
              _focusNode.unfocus();
            } else {
              FocusScope.of(context).requestFocus(_focusNode);
            }
          }),
        ],
      ),
    );
  }

  Widget buildSvgPictureIcon(String path, double size, {dynamic onTap}) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        path,
        width: su.ScreenUtil().setWidth(size),
        height: su.ScreenUtil().setHeight(size),
      ),
    );
  }

  // emoji 面板
  Widget _emoJiList() {
    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/json/emoji.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = json.decode(snapshot.data.toString());

            return Container(
              height: _keyboardHeight,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
              color: Colors.white,
              child: GridView.custom(
                padding: EdgeInsets.all(3),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 0.5,
                  crossAxisSpacing: 6.0,
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        insertText(String.fromCharCode(data[index]['unicode']));
                      },
                      child: Center(
                        child: Text(
                          String.fromCharCode(data[index]['unicode']),
                          style: TextStyle(fontSize: 33),
                        ),
                      ),
                    );
                  },
                  childCount: data.length,
                ),
              ),
            );
          }
          return Center(
              child: SizedBox(
                  width: 40, height: 40, child: CircularProgressIndicator()));
        });
  }

  void insertText(String text) {
    var value = _textEditingController.value;
    var start = value.selection.baseOffset;
    var end = value.selection.extentOffset;
    if (value.selection.isValid) {
      var newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }
      _textEditingController.value = value.copyWith(
          text: newText,
          selection: value.selection.copyWith(
              baseOffset: end + text.length, extentOffset: end + text.length));
      _textEditingController.selection =
          TextSelection.fromPosition(TextPosition(offset: newText.length));
    } else {
      print('选择无效');
      _textEditingController.value = TextEditingValue(
          text: text,
          selection:
              TextSelection.fromPosition(TextPosition(offset: text.length)));
    }
    moveCursorToLast();
  }

  // 删除一个商品卡片
  void deleteOneGoodsCard(dynamic json) {
    // 当前输入框中的实际文本
    var actualText = _textEditingController.value.text;

    // 将要删除的字符串
    var wellDeleteStr = '[goodsId=${json.toString()}End]';

    // 替换
    var newValue = actualText.replaceAll(wellDeleteStr, '');

    // 设置
    _textEditingController.value = TextEditingValue(text: newValue);

    moveCursorToLast();
  }

  // 把光标位置移动到最后
  void moveCursorToLast() {
    _textEditingController.selection = TextSelection.fromPosition(TextPosition(
        offset: _textEditingController.value.text.length,
        affinity: TextAffinity.downstream));
    print('光标已经移动到最后');
  }

  // 移除光标
  void removeCursor() {
    _focusNode.unfocus();
  }

  void manualDelete() {
    //delete by code
    final _value = _textEditingController.value;
    final selection = _value.selection;
    if (!selection.isValid) return;

    TextEditingValue value;
    final actualText = _value.text;
    if (selection.isCollapsed && selection.start == 0) return;
    final start = selection.isCollapsed ? selection.start - 1 : selection.start;
    final end = selection.end;

    value = TextEditingValue(
      text: actualText.replaceRange(start, end, ''),
      selection: TextSelection.collapsed(offset: start),
    );

    final oldTextSpan = _mySpecialTextSpanBuilder.build(_value.text);

    value = handleSpecialTextSpanDelete(value, _value, oldTextSpan, null);

    _textEditingController.value = value;
  }
}
