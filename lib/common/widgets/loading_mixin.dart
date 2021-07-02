import 'package:flutter/cupertino.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool loadingState = true;

  String error = '';

  void setError(String msg) {
    if (mounted) {
      setState(() {
        error = msg;
      });
    }
  }

  void setLoading(bool value) {
    if (mounted) {
      setState(() {
        loadingState = value;
      });
    }
  }

  Widget errorMsgWidget() {
    return Container(
      child: Center(
        child: Text('$error'),
      ),
    );
  }
}
