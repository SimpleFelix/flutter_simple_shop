import '../index_page/component/category_component.dart';
import 'package:flutter/material.dart';

class CategoryDelegate extends SliverPersistentHeaderDelegate {
  final SelectWithItem onSelect;
  final CategoryController controller;
  CategoryDelegate(this.onSelect, this.controller);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        height: 75,
        color: Colors.white,
        alignment: Alignment.center,
        child: CategoryComponent(
          onSelect: onSelect,
          controller: controller,
          textStyle: TextStyle(fontSize: 14, color: Colors.black),
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 75;

  @override
  // TODO: implement minExtent
  double get minExtent => 75;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
