// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../widgets/simple_appbar.dart';
import 'components/blog_categorys.dart';
import 'components/tags.dart';
import 'logic.dart';

// 发布博客页面
class WriteBlogPage extends StatefulWidget {
  @override
  _WriteBlogPageState createState() => _WriteBlogPageState();
}

class _WriteBlogPageState extends State<WriteBlogPage> {
  final WriteBlogLogic logic = Get.put(WriteBlogLogic());
  final TextEditingController tagController = TextEditingController();
  final FocusNode tagFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    logic.getBlogCategorys(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: '发布博客'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            renderComponent(
              title: '请输入标题',
              child: TextField(
                onChanged: logic.titleChange,
              ),
            ),
            renderComponent(
              title: '请选择分类',
              child: Obx(() {
                return BlogCategorys(select: logic.select.value, onSelect: logic.onSelect);
              }),
            ),
            renderComponent(
                title: '请输入正文内容',
                child: TextField(
                  minLines: 6,
                  maxLines: 12,
                  onChanged: logic.contentChange,
                )),
            renderComponent(
                title: '添加文章标签',
                child: TextField(
                  controller: tagController,
                  focusNode: tagFocusNode,
                  onSubmitted: (v) {
                    logic.addTag(v);
                    tagController.clear();
                    tagFocusNode.requestFocus();
                  },
                )),
            renderComponent(title: '已添加标签', child: WriteBlogTags()),
            renderComponent(
                title: '操作',
                child: Row(
                  children: [
                    Obx(() {
                      return FancyElevatedButton(
                        onPressed: logic.submit,
                        isLoading: logic.submitLoading.value,
                        child: Text('发布'),
                      );
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<WriteBlogLogic>();
    tagController.dispose();
    tagFocusNode.dispose();
    super.dispose();
  }

  Widget renderComponent({String? title, Widget? child}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Container(margin: EdgeInsets.only(bottom: 6), child: Text('$title')),
          if (child != null) child,
        ],
      ),
    );
  }
}
