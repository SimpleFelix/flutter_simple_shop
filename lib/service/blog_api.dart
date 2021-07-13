import 'dart:convert';

import 'package:demo1/common/utils.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// 博客api
class BlogApi {
  /// 发布一篇新博客
  Future<void> pishNewBlog(String title, String content, List<String> tags, String categoryId, {String? alias}) async {}

  /// 获取分类列表
  Future<void> getCategorys() async {
    final result = await utils.api.get('/api/blog/category-list',otherDataHandle: (data){
      Logger().wtf(data);
    });

  }
}
