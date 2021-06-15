import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils.dart';
import '../../../../widgets/product_search_mini.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('搜索产品'),),
      body: Container(
        height: utils.widgetUtils.kBodyHeight,
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: CupertinoSearchTextField(),
            ),
            Expanded(child: ProductSearchMini(keyWorlds: ''))
          ],
        ),
      ),
    );
  }
}
