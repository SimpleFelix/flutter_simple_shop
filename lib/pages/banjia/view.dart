import 'package:demo1/pages/banjia/resp.dart';
import 'package:demo1/widgets/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 每日半价页面
class BanjiaIndex extends StatefulWidget {
  const BanjiaIndex({Key? key}) : super(key: key);

  @override
  _BanjiaIndexState createState() => _BanjiaIndexState();
}

class _BanjiaIndexState extends State<BanjiaIndex> {




  @override
  void initState() {
    Future.microtask(() {
      context.read(banjiaRiverpod).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: '每日半价',),
      body: EasyRefresh.custom(slivers: [

      ]),
    );
  }
}
