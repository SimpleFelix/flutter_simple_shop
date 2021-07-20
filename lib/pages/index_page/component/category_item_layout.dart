import 'package:flutter/material.dart';

import 'category_notification_stream.dart';

class CategoryItemDefaultLayout extends StatefulWidget {
  final int? index;
  final String? name;
  final TextStyle? textStyle;
  final TextStyle? currentStyle;
  final int? current;
  final OnRenderEnd onRendeEnd;

  const CategoryItemDefaultLayout(
      {this.index, this.name, this.textStyle, Key? key, this.current, this.currentStyle, required this.onRendeEnd})
      : super(key: key);

  @override
  _CategoryItemDefaultLayoutState createState() => _CategoryItemDefaultLayoutState();
}

class _CategoryItemDefaultLayoutState extends State<CategoryItemDefaultLayout> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _notificationWidgetInfoTo();
    });

    CategoryNotificationStreamUtil.instance.changeStream!.listen((event) {
      _notificationWidgetInfoTo();
    });

    super.initState();
  }

  void _notificationWidgetInfoTo() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    widget.onRendeEnd(widget.index, box.localToGlobal(Offset.zero), context.size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12, left: widget.index == 0 ? 12 : 0),
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: widget.index == widget.current
          ? Text(
              widget.name!,
              style: widget.currentStyle ?? TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
            )
          : Text(
              widget.name!,
              style: widget.textStyle ?? TextStyle(fontSize: 12, color: Color.fromRGBO(255, 255, 255, .65)),
            ),
    );
  }

  @override
  void dispose() {
    CategoryNotificationStreamUtil.instance.disposeStream();
    super.dispose();
  }
}

typedef OnRenderEnd = void Function(int? index, Offset offset, Size? size);
