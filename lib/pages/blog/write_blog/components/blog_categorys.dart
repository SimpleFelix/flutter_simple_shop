import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../../../modals/blog_category_model.dart';
import '../../../../provider/riverpod/category_riverpod.dart';

class BlogCategorys extends ConsumerWidget {
  final ValueChanged<BlogCategory>? onSelect;
  final BlogCategory? select; // 选中的

  const BlogCategorys({Key? key, this.onSelect, this.select}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final blogCates = watch(categoryRiverpod).blogCategorys;
    if (blogCates.isEmpty) return Container();
    return WaterfallFlow.count(
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: blogCates.map(renderItem).toList(),
    );
  }

  Widget renderItem(BlogCategory blogCategory) {
    return GestureDetector(
      onTap: () {
        onSelect?.call(blogCategory);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: select != null && select!.id == blogCategory.id ? Colors.blue : Colors.black)),
        child: Text(
          '${blogCategory.name}',
          style: TextStyle(color: select != null && select!.id == blogCategory.id ? Colors.blue : Colors.black),
        ),
      ),
    );
  }
}
