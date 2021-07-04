import 'package:demo1/pages/index_page/new/index_riverpod.dart';
import 'package:demo1/pages/panic_buying/components/list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IndexProductss extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(indexRiverpod).products;
    if(list.isEmpty) return SliverToBoxAdapter();
    return ProductsList(list);
  }

}