import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../common/components/pdd/view.dart';
import '../../../modals/pdd_search_item_model.dart';
import '../../../service/api_service.dart';
import '../../../widgets/appbar_search.dart';
import '../../../widgets/component/coupon_discount.dart';
import '../../../widgets/extended_image.dart';
import '../../../widgets/simple_price.dart';
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
          return SliverFillRemaining(
              child: AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: products.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (_, index) => renderItem(products[index]),
                    itemCount: products.length,
                  )
                : PddRecommendListView(),
          ));
        })
      ]),
    );
  }

  Widget renderItem(PddSearchItemModel item) {
    return GestureDetector(
      onTap: () {
        tkApi.pddCovert(item.goodsSign);
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
                  width: 100,
                  height: 100,
                  child: SimpleImage(
                    url: '${item.goodsImageUrl}',
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  constraints: BoxConstraints(minHeight: 100),
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
                            height: 2,
                          ),
                          CouponDiscountShow(value: '${item.couponDiscount}')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 销量
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(2)),
                                child: Text(
                                  '全网销量${item.salesTip}',
                                  style: TextStyle(color: Colors.red, fontSize: 10),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              SimplePrice(
                                price: '${item.minGroupPrice}',
                                hideText: '到手价',
                                fontSize: 14,
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${item.mallName}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10, color: Colors.grey),
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
