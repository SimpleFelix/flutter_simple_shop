import 'package:dd_taoke_sdk/model/category.dart';
import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../../widgets/extended_image.dart';
import '../new_goods_list/view.dart';

class RightWidgetItme extends StatelessWidget {
  final Subcategory item;
  final Category category;

  RightWidgetItme({required this.item, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // NavigatorUtil.gotoGoodslistPage(context,
        //     subcid: item.subcid.toString(), title: item.subcname, cids: cid);
        utils.widgetUtils.to(NewGoodsList(
          category: category,
          subcategory: item,
        ));
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ExtendedImageWidget(
              src: item.scpic!,
              width: 50,
              height: 50,
            ),
            Text(item.subcname!)
          ],
        ),
      ),
    );
  }
}
