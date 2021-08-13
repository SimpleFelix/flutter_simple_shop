// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../../../provider/riverpod/search_riverpod.dart';
import '../../../widgets/loading_widget.dart';

class SearchInitLoadingStatus extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final loading = watch(searchRiverpod).initLoading;
    if(loading){
      return SliverToBoxAdapter(
        child: LoadingWidget(),
      );
    }
    return SliverToBoxAdapter(child: Container(),);
  }

}
