// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:loading_more_list/loading_more_list.dart';

/// 功能组组件
class MyWrap extends StatelessWidget {
  final List<Widget> children;
  final String? title;

  const MyWrap({Key? key, required this.children, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Container(margin: EdgeInsets.only(bottom: 12), child: Text('$title')),
          WaterfallFlow.count(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: children,
          ),
        ],
      ),
    );
  }
}
