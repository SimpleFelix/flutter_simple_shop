import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../common/components/pdd/view.dart';
import '../../../modals/pdd_search_item_model.dart';
import '../../../widgets/appbar_search.dart';
import '../../../widgets/component/coupon_discount.dart';
import '../../../widgets/extended_image.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/simple_price.dart';
import '../../public_detail/view.dart';
import 'logic.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchLogic logic = Get.put(SearchLogic());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBarSearch(
        hintText: '搜索拼多多隐藏优惠券',
        onSearch: logic.onSearch,
      ),
      body: EasyRefresh.custom(slivers: [
        Obx(() {
          final products = logic.products;
          final loading = logic.loading.value;
          return SliverFillRemaining(
              child: AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: products.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (_, index) => renderItem(products[index]),
                    itemCount: products.length,
                  )
                : loading
                    ? LoadingWidget()
                    : PddRecommendListView(),
          ));
        })
      ]),
    );
  }

  Widget renderItem(PddSearchItemModel item) {
    return GestureDetector(
      onTap: () {
        context.navigator.push(SwipeablePageRoute(builder: (_) => PublicDetailView(goodsId: item.goodsSign, type: 'pdd')));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: SimpleImage(
                    url: '${item.goodsImageUrl}',
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  constraints: BoxConstraints(minHeight: 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.goodsName}',
                            style: TextStyle(color: Colors.black45, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CouponDiscountShow(value: '${item.couponDiscount}')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 销量
                          Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(2)),
                              child: Text(
                                '全网销量${item.salesTip}',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              SimplePrice(
                                price: '${item.minGroupPrice}',
                                hideText: '到手价',
                                fontSize: 20,
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${item.mallName}',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }
}
