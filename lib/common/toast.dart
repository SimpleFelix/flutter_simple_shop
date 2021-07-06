import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String text) {
  print('显示一个简单弹窗');
}

void showLoading(BuildContext context, [String? text]) {
  var loadingWidget = Container(
    child: CircularProgressIndicator(),
  );
  if (GetPlatform.isIOS) {
    loadingWidget = Container(child: CupertinoActivityIndicator());
  }

  Get.dialog(AlertDialog(
    content: SingleChildScrollView(child: Center(child: loadingWidget)),
  ));
}

void closeLoading() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

void showConfirmDialog(BuildContext context, String content, Function confirmCallback) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                confirmCallback();
                Navigator.of(context).pop();
              },
              child: Text('确认'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
          ],
        );
      });
}
