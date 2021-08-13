// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../../provider/riverpod/search_riverpod.dart';
import '../list.dart';

/// 搜索关键字组件
class SearchKeyWorlds extends StatefulWidget {
  const SearchKeyWorlds({Key? key}) : super(key: key);

  @override
  _SearchKeyWorldsState createState() => _SearchKeyWorldsState();
}

class _SearchKeyWorldsState extends State<SearchKeyWorlds> {
  List<String> _keyWorlds = List.generate(10, (index) => '        ');

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
            '搜索发现',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 12,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: _keyWorlds.map(_item).toList(),
          ),
        ],
      ),
    );
  }

  Widget _item(String item) {
    return InkWell(
      onTap: () {
        context.read(searchRiverpod).loadData(worlds: item);
        Get.to(() => SearchListIndex(value: item));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
        child: Text(item),
      ),
    );
  }

  @override
  void initState() {
    Future.microtask(() async {
      final result = await DdTaokeSdk.instance.getSuggest();
      if (mounted) {
        _keyWorlds.clear();
        setState(() {
          _keyWorlds = result.sublist(0, 10);
        });
      }
    });
    super.initState();
  }
}
