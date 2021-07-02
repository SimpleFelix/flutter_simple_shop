import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/loading_widget.dart';
import '../repository.dart';

/// 页面状态显示
class ViewStatusWithPanicBuy extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final changeLoading = watch(panicBuyingRiverpod).changeLoading;
    if (changeLoading) {
      return LoadingWidget();
    }
    return Container();
  }
}
