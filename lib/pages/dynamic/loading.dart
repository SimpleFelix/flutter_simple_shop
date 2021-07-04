import 'package:demo1/pages/dynamic/pyq_riverpod.dart';
import 'package:demo1/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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