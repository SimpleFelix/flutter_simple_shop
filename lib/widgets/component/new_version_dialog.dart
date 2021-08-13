// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../common/toast.dart';
import '../../common/utils.dart';

/// 新版本弹窗
class NewVersionDialog extends StatefulWidget {
  final Map<String,dynamic> map;
  const NewVersionDialog({Key? key,required this.map}) : super(key: key);

  @override
  _NewVersionDialogState createState() => _NewVersionDialogState();
}

class _NewVersionDialogState extends State<NewVersionDialog> {
  @override
  Widget build(BuildContext context) {
    final desc = widget.map['desc'].toString();
    final url = widget.map['downUrl'].toString();
    return AlertDialog(
      title: Text('新版本发布!'),
      content: Text('$desc'),
      actions: [
        TextButton(onPressed: Get.back, child: Text('忽略')),
        ElevatedButton(onPressed: () async {
            if(url.isNotEmpty){
              print('配置的下载页面地址是:$url');
              await utils.openLink(url);
              Get.back();
            }else{
              showToast('未配置下载页面url');
              Get.back();
            }
        }, child: Text('前往下载'))
      ],
    );
  }
}
