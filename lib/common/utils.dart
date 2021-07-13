import 'dart:io';

// import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:demo1/service/user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../fluro/navigator_util.dart';
import 'service.dart';
import 'widget_util.dart';

/// 工具类
class Utils {
  WidgetUtils get widgetUtils => GetIt.instance.get<WidgetUtils>();

  NavigatorUtil get routerUtils => GetIt.instance.get<NavigatorUtil>();

  Api get api => GetIt.instance.get<Api>();
  UserApi get userApi => GetIt.instance.get<UserApi>();

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
    if (GetPlatform.isWindows) {
      // final file = OpenFilePicker()
      //   ..filterSpecification = {
      //     '图片文件 (*.jpg; *.png)': '*.jpg;*.png',
      //   }
      //   ..defaultFilterIndex = 0
      //   ..defaultExtension = 'jpg'
      //   ..title = '选择图片上传';
      //
      // final result = file.getFile();
      // if (result != null) {
      //   return result;
      // }
    } else if (GetPlatform.isAndroid) {
      var _imagePicker = await ImagePicker().getImage(source: ImageSource.gallery);
      var file = File(_imagePicker!.path);
      return file;
    }
  }

  //处理图片不带http
  String imageHeaderHandle(String url) {
    if (url.indexOf('//') == 0) {
      return 'https:$url';
    }
    return url;
  }

  // 复制
  void copy(String? text,{String? message}) {
    Clipboard.setData(ClipboardData(text: text));
    showMessage(message??'复制成功');
  }

  Future<void> navToBrowser(String url)async{
    if (await canLaunch(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(url);
    }else{
      copy(url,message: '跳转url失败,链接已复制到剪贴板');
    }
  }

  // 跳转到浏览器
  Future<void> openLink(String url)async{
    if (await canLaunch(url)) {
      await launch(url);
    }else{
      copy(url,message: '跳转url失败,链接已复制到剪贴板');
    }
  }

  // 打开淘宝
  Future<void> openTaobao(String url) async {


    /// 如果是windows平台,直接跳转到浏览器打开链接
    if(GetPlatform.isWindows){
      await launch(url);
      return;
    }


    var _url = url;
    if (_url.indexOf('http://') == 0) {
      _url = _url.replaceAll('http://', '');
    } else if (_url.indexOf('https://') == 0) {
      _url = _url.replaceAll('https://', '');
    }
    _url = 'taobao://$_url';
    if (await canLaunch(_url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(_url);
    } else {
      await Get.dialog(AlertDialog(
        title: Text('打开淘宝APP失败'),
        content: Text('请检查是否安装淘宝APP'),
        actions: [
          TextButton(
              onPressed: () {
                copy(url);
              },
              child: Text('复制链接')),
          ElevatedButton(
              onPressed: () {
                launch(url);
              },
              child: Text('跳转到浏览器领取'))
        ],
      ));
    }
  }
}

Utils get utils => GetIt.instance.get<Utils>();
