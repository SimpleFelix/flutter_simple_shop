import 'dart:io';

import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../fluro/NavigatorUtil.dart';
import 'service.dart';
import 'widget_util.dart';

/// 工具类
class Utils {
  WidgetUtils get widgetUtils => GetIt.instance.get<WidgetUtils>();

  NavigatorUtil get routerUtils => GetIt.instance.get<NavigatorUtil>();

  Api get api => GetIt.instance.get<Api>();

  // 显示一条消息
  void showMessage(String msg) {
    final _context = Get.context;
    if (_context != null) {
      ScaffoldMessenger.of(_context).removeCurrentSnackBar();
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  // 选择文件
  Future<File?> selectFile() async {
    if(GetPlatform.isWindows){
      final file = OpenFilePicker()
        ..filterSpecification = {
          '图片文件 (*.jpg; *.png)': '*.jpg;*.png',
        }
        ..defaultFilterIndex = 0
        ..defaultExtension = 'jpg'
        ..title = '选择图片上传';

      final result = file.getFile();
      if (result != null) {
        return result;
      }
    }else if(GetPlatform.isAndroid){
      var _imagePicker = await ImagePicker().getImage(source: ImageSource.gallery) ;
      var file = File(_imagePicker!.path);
      return file;
    }

  }
}

Utils get utils => GetIt.instance.get<Utils>();
