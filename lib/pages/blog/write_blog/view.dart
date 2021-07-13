import 'package:demo1/widgets/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

// 发布博客页面
class WriteBlogPage extends StatefulWidget {
  @override
  _WriteBlogPageState createState() => _WriteBlogPageState();
}

class _WriteBlogPageState extends State<WriteBlogPage> {
  final WriteBlogLogic logic = Get.put(WriteBlogLogic());



  @override
  void initState() {
    super.initState();
    logic.getBlogCategorys(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: '发布博客'),
    );
  }

  @override
  void dispose() {
    Get.delete<WriteBlogLogic>();
    super.dispose();
  }
}
