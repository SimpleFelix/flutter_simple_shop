// Dart imports:

// Package imports:
import 'package:badges/badges.dart';
import 'package:dd_taoke_sdk/model/hot_search_worlds_result.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../../common/widgets/hot.dart';
import '../../../provider/riverpod/search_riverpod.dart';
import '../../../widgets/extended_image.dart';
import '../list.dart';
import '../logic.dart';

class Suggest extends StatelessWidget {
  const Suggest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '热搜榜',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 12,
          ),
          Obx(() {
            final suggs = SearchLogic.instance.suggest;
            return Wrap(
              children: suggs.map(_renderItem).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _renderItem(HotSearchWorlds item) {
    return InkWell(
      onTap: () {
        Get.context!.read(searchRiverpod).loadData(worlds: item.words);
        Get.to(() => SearchListIndex(value: item.words ?? ''));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 58,
              child: Container(
                alignment: Alignment.center,
                child: Text('${item.rankNum!}'),
              ),
            ),
            SizedBox(
              width: 58,
              height: 58,
              child: SimpleImage(url: item.pic!),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: Container(
              constraints: BoxConstraints(minHeight: 58),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.theme!,
                        style: TextStyle(color: Colors.black),
                      ),
                      if (item.label!.isNotEmpty)
                        Badge(
                          badgeContent: Text(
                            item.label!,
                            style: TextStyle(color: Colors.pink, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          badgeColor: Colors.white,
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Hot(text: ' ${item.hotValue}  热度')
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
