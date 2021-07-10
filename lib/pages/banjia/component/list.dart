import 'package:badges/badges.dart';
import 'package:dd_taoke_sdk/model/halfday_result.dart';
import 'package:demo1/fluro/navigator_util.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:demo1/widgets/simple_price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

class BanjiaList extends StatelessWidget {
  final List<ListElement> products;

  const BanjiaList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverWaterfallFlow.count(
      crossAxisCount: 1,
      children: products.map(renderItem).toList(),
    );
  }

  Widget renderItem(ListElement item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: SimpleImage(
              url: item.picUrl!,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
              child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.name}'),
                    SizedBox(
                      height: 5,
                    ),
                    Badge(
                      badgeContent: Text(
                        '${item.yijuhua}',
                        style: TextStyle(color: Colors.pink),
                      ),
                      shape: BadgeShape.square,
                      badgeColor: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      elevation: 0,
                      borderSide: BorderSide(color: Colors.pinkAccent),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimplePrice(
                      price: '${item.price}',
                      hideText: '',
                    ),
                    ElevatedButton(
                        onPressed: () {
                          NavigatorUtil.gotoGoodsDetailPage(Get.context!, '${item.id}',newViewPage: true);
                        },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink)
                      ),
                        child: Text((item.itemSoldNum ?? 0) == 0
                            ? '去抢购'
                            : '已抢${item.itemSoldNum}'),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
