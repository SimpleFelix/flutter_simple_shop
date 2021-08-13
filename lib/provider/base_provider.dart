// Flutter imports:
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool loading = false;

//  改变加载状态
  void changeLoadingState(bool state) {
    loading = state;
    notifyListeners();
  }
}
