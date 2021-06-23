import 'package:demo1/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository.dart';

/// 页面状态显示
class ViewStatusWithPanicBuy extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final initLoading = watch(panicBuyingRiverpod).initLoading;
    if(initLoading){
      return LoadingWidget();
    }
    return Container();
  }

}