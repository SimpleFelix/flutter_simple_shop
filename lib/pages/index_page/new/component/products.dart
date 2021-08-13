// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../panic_buying/components/list.dart';
// Project imports:
import '../index_riverpod.dart';

class IndexProductss extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(indexRiverpod).products;
    if(list.isEmpty) return SliverToBoxAdapter();
    return ProductsList(list);
  }

}
