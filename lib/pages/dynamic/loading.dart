// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/loading_widget.dart';
// Project imports:
import 'pyq_riverpod.dart';

class PyQLoading extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final loading = watch(pyqRiverpod).loading;
    var contaner = Container();
    if(loading){
      contaner = Container(child: LoadingWidget(),);
    }
    return SliverToBoxAdapter(
      child: contaner,
    );
  }

}
