import 'package:demo1/pages/jiujiu_page/image_nav.dart';
import 'package:demo1/pages/jiujiu_page/loading_status.dart';
import 'package:demo1/pages/jiujiu_page/riverpod.dart';
import 'package:demo1/widgets/RoundUnderlineTabIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../provider/nine_goods_provider.dart';
import 'list.dart'; // 9.9包邮的provider

// 9.9包邮专区
class JiujiuIndexHome extends StatefulWidget {
  final ScrollController? scrollController;

  JiujiuIndexHome({this.scrollController});

  @override
  _JiujiuIndexHomeState createState() => _JiujiuIndexHomeState();
}

class _JiujiuIndexHomeState extends State<JiujiuIndexHome>
    with TickerProviderStateMixin {
  bool initLoading = false;
  bool nextPageLoading = false;

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    Future.microtask(context.read(jiujiuRiverpod).init);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('9块9包邮',style: TextStyle(color: Colors.black)),
        bottom: PreferredSize(preferredSize: Size(Get.width,48),
        child: Container(
          alignment: Alignment.centerLeft,
          child: TabBar(
            onTap:context.read(jiujiuRiverpod).changeIndex,
            controller: tabController,
            isScrollable: true,
            indicator: RoundUnderlineTabIndicator(
                insets: EdgeInsets.only(bottom: 8),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.pinkAccent,
                )),
            tabs: [
              Tab(
                text: '精选',
              ),
              Tab(
                text: '5.9元区',
              ),
              Tab(
                text: '9.9元区',
              ),
              Tab(
                text: '19.9元区',
              ),
            ],
            labelColor: Colors.pinkAccent,
            labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600),
            indicatorColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle:
            TextStyle(fontSize: 12),
          ),
        ),

        ),
      ),
      body: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter(),
          onRefresh: context.read(jiujiuRiverpod).refresh,
          onLoad: context.read(jiujiuRiverpod).nextPage,
          slivers: [
            JiuJiuLoadingStatus(),
            JiuJiuProductList()
          ]),
    );
  }

  Row buildRow2() {
    return Row(
      children: <Widget>[
        Container(
          child: ImageNav(
            height: 360,
            width: 720,
            src:
                'https://img.alicdn.com/imgextra/i2/2053469401/O1CN019KHY9k2JJi0Bt8k5B_!!2053469401.jpg',
            onTap: () {},
            title: Text(
              '19.9元专区',
              style: TextStyle(color: Color.fromRGBO(253, 87, 92, 1.0)),
            ),
            subTitle: Text(
              '半价抢不停',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                'https://img.alicdn.com/imgextra/i4/2053469401/O1CN01uyQmiF2JJi15GeiZE_!!2053469401.jpg',
            onTap: () {},
            title: Text(
              '驱蚊止痒',
              style: TextStyle(color: Color(0xff8FBC8F)),
            ),
            subTitle: Text(
              '不怕蚊虫',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                'https://img.alicdn.com/imgextra/i1/2053469401/O1CN01Wl3zrd2JJi13RVIY6_!!2053469401.jpg',
            onTap: () {},
            title: Text(
              '潮流T恤',
              style: TextStyle(color: Color(0xffDC143C)),
            ),
            subTitle: Text(
              '清凉一夏',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        )
      ],
    );
  }

  Row buildRow1() {
    return Row(
      children: <Widget>[
        Container(
          child: ImageNav(
            height: 360,
            width: 720,
            src:
                'https://img.alicdn.com/imgextra/i1/2053469401/O1CN01DKsIHJ2JJi0Bt78I3_!!2053469401.jpg',
            onTap: () {},
            title: Text(
              '9块9每日精选',
              style: TextStyle(color: Color(0xffFF1493)),
            ),
            subTitle: Text(
              '十元封顶',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                'https://img.alicdn.com/imgextra/i3/2053469401/O1CN01R48n0q2JJi16huc5i_!!2053469401.jpg',
            onTap: () {},
            title: Text(
              '粽香四溢',
              style: TextStyle(color: Color(0xff4169E1)),
            ),
            subTitle: Text(
              '传统味道',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                'https://img.alicdn.com/imgextra/i4/2053469401/O1CN017g9IMN2JJi12uMZ1g_!!2053469401.jpg',
            onTap: () {},
            title: Text(
              '美妆必备',
              style: TextStyle(color: Color.fromRGBO(114, 11, 252, 1.0)),
            ),
            subTitle: Text(
              '\'妆\'出精致',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        )
      ],
    );
  }

  void _setInitLoadingState(bool isLoading) {
    setState(() {
      initLoading = isLoading;
    });
  }

//  选项卡被切换
  void onChangeCallBack(index, cid) async {
    _setInitLoadingState(true);
    _setInitLoadingState(false);
  }
}
