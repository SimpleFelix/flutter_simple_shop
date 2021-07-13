import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/riverpod/category_riverpod.dart';

class WriteBlogLogic extends GetxController {


  /// 获取博客的分类
  Future<void> getBlogCategorys(BuildContext context) async {
    await context.read(categoryRiverpod).getBlogCategory();
  }

}
