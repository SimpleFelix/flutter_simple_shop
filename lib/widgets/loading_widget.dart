import 'package:flutter/material.dart';

import '../util/extended_util.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height:bodyHeight(context),
      width: pw(context),
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.red),
      ),
    );
  }
}
