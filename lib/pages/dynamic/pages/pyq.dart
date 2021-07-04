import 'package:demo1/pages/dynamic/components/list.dart';
import 'package:demo1/pages/dynamic/pyq_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../loading.dart';

/// 朋友圈
class PyqView extends StatefulWidget {
  const PyqView({Key? key}) : super(key: key);

  @override
  _PyqViewState createState() => _PyqViewState();
}

class _PyqViewState extends State<PyqView> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read(pyqRiverpod).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      slivers: [
        PyQLoading(),
        PyqList()
      ],
      onLoad: ()async{
        await context.read(pyqRiverpod).nextPage();
      },
      footer: MaterialFooter(),
    );
  }
}
