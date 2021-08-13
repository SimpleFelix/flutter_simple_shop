// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:demo1/pages/jiujiu_page/riverpod.dart';
import 'package:demo1/widgets/loading_widget.dart';

class JiuJiuLoadingStatus extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final loading = watch(jiujiuRiverpod).loading;
    if(loading){
      return SliverToBoxAdapter(
        child: LoadingWidget(),
      );
    }
    return SliverToBoxAdapter(child: Container(),);
  }

}
