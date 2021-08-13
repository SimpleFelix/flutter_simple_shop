// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:demo1/widgets/component/custom_skeleton_container.dart';

class Skeleton extends StatelessWidget {
  final Widget? child;

  Skeleton({this.child});

  @override
  Widget build(BuildContext context) {
    return LoadAnimation(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white), color: Colors.white),
        child: child,
      ),
    );
  }
}
