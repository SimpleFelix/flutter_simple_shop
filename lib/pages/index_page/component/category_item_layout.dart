import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      print("$event");
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
      margin: EdgeInsets.only(right: 50.w, left: widget.index == 0 ? 25.w : 0),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      alignment: Alignment.topCenter,
      child: widget.index == widget.current
          ? Text(
              widget.name!,
              style: widget.currentStyle ?? TextStyle(fontSize: 55.sp, color: Theme.of(context).primaryColor),
            )
          : Text(
              widget.name!,
              style: widget.textStyle ?? TextStyle(fontSize: 55.sp, color: Color.fromRGBO(255, 255, 255, .65)),
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
