import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'pages/pyq.dart';

/// 动态
class DynamicIndex extends StatefulWidget {
  const DynamicIndex({Key? key}) : super(key: key);

  @override
  _DynamicIndexState createState() => _DynamicIndexState();
}

class _DynamicIndexState extends State<DynamicIndex>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TabBar(
            tabs: [
              Tab(
                text: '动态',
              ),
              Tab(
                text: '发现',
              ),
            ],
            controller: tabController,
            isScrollable: true,
          ),
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          PyqView(),
          Container(),
        ],
      ),
    );
  }
}
