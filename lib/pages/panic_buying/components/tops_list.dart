import 'package:badges/badges.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:demo1/pages/panic_buying/repository.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

/// 排行前三的商品
class TopsProducts extends ConsumerWidget {
  const TopsProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tops = watch(panicBuyingRiverpod).tops;
    if (tops.isEmpty) return SliverToBoxAdapter(child: Container());
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      sliver: SliverWaterfallFlow.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: [
          renderItem(tops[1], 1),
          renderItem(tops[0], 0),
          renderItem(tops[2], 2),
        ],
      ),
    );
  }

  /// 渲染项目
  Widget renderItem(Product item, int index) {
    return Container(
      height: 180,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxWidth,
                      child: Stack(
                        children: [
                          SimpleImage(url: item.mainPic!),
                          Positioned(
                            left: 2,
                            child:  Badge(
                            toAnimate: false,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(8),
                            badgeContent: Text('${index+1}', style: TextStyle(color: Colors.white)),
                          ),)
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text('${item.dtitle}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontSize: 12
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,left: 5),
                    alignment: Alignment.centerLeft,
                    child: FSuper(
                      lightOrientation: FLightOrientation.LeftBottom,
                      spans: [
                        TextSpan(text: '¥',style: TextStyle(color: Colors.pink,fontSize: 12)),
                        TextSpan(text: '${item.actualPrice}',style: TextStyle(color: Colors.pink,fontSize: 18,fontWeight: FontWeight.bold)),
                        TextSpan(text: ' 券后',style: TextStyle(color: Colors.pink,fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
