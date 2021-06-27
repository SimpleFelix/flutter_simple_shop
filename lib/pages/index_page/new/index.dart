import 'package:demo1/pages/index_page/new/component/appbar.dart';
import 'package:flutter/material.dart';


/// 新版首页
class IndexHomeNew extends StatelessWidget {
  const IndexHomeNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndexHomeAppbar(),
    );
  }
}
