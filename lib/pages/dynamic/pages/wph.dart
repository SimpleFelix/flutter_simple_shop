import 'package:badges/badges.dart';
import 'package:demo1/pages/dynamic/wph_riverpod.dart';
import 'package:demo1/pages/index_page/store/price_layout.dart';
import 'package:demo1/service/api_service.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/dom.dart' as dom;

/// 唯品会精编商品列表
class WeipinhuiJinBianGoods extends StatefulWidget {
  const WeipinhuiJinBianGoods({Key? key}) : super(key: key);

  @override
  _WeipinhuiJinBianGoodsState createState() => _WeipinhuiJinBianGoodsState();
}

class _WeipinhuiJinBianGoodsState extends State<WeipinhuiJinBianGoods> {
  @override
  void initState() {
    super.initState();
    context.read(wphRiverpod).init();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      slivers: [
        Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final list = watch(wphRiverpod).products;
            return SliverList(delegate: SliverChildBuilderDelegate((_, index) => renderItem(list[index]), childCount: list.length));
          },
        )
      ],
      onLoad: context.read(wphRiverpod).nextPage,
    );
  }

  Widget renderItem(dynamic item) {
    return GestureDetector(
      onTap: (){
        tkApi.getWphProductInfo(item['id']);
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.redAccent)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    renderSvg(),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '${item['shop_name']}',
                      style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Html(
                      data: '${item['content']}',
                      onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                        print('点击的链接是:$url');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: SimpleImage(url: item['pic']),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      '特卖价',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  PriceLayout(original: '${item['quanhou_price']}', discounts: ''),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderSvg() {
    return SvgPicture.asset(
      'assets/svg/brand.svg',
      width: 23,
      height: 23,
      color: Colors.red,
    );
  }
}
