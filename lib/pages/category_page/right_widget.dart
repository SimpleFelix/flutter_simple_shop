import 'package:dd_taoke_sdk/model/category.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/material.dart';
import '../../fluro/navigator_util.dart';

class RightWidgetItme extends StatelessWidget {
  final Subcategory item;
  final String? cid;

  RightWidgetItme({required this.item, this.cid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.gotoGoodslistPage(context,
            subcid: item.subcid.toString(), title: item.subcname, cids: cid);
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
