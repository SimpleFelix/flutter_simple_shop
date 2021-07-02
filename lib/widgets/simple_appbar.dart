import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? subTitle;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final double? bottomHeight;

  const SimpleAppBar({Key? key, required this.title, this.subTitle, this.elevation, this.bottom, this.bottomHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MorphingAppBar(
      backgroundColor: Colors.white,
      title: TitleAndSubtitle(
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: subTitle,
      ),
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: elevation ?? 3,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom != null ? kToolbarHeight + (bottomHeight ?? 0) : kToolbarHeight);
}
