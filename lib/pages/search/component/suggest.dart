import 'dart:convert';

import 'package:dd_taoke_sdk/model/hot_search_worlds_result.dart';
import 'package:demo1/common/widgets/hot.dart';
import 'package:demo1/pages/search/logic.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    print(jsonEncode(item));
    return Container(
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
                Text(item.theme!),
                SizedBox(
                  height: 5,
                ),
                Hot(text: '热度 ${item.hotValue}')
              ],
            ),
          ))
        ],
      ),
    );
  }
}
