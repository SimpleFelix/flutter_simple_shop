import 'dart:io';

import 'package:dd_taoke_sdk/dd_taoke_sdk_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/navigator_util.dart';
import '../service/blog_api.dart';
import '../service/user_api.dart';
import 'service.dart';
import 'widget_util.dart';

/// 工具类
class Utils {
  WidgetUtils get widgetUtils => GetIt.instance.get<WidgetUtils>();

  NavigatorUtil get routerUtils => GetIt.instance.get<NavigatorUtil>();

  Api get api => GetIt.instance.get<Api>();

  UserApi get userApi => GetIt.instance.get<UserApi>();

  BlogApi get blogApi => GetIt.instance.get<BlogApi>();

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
  void copy(String? text, {String? message}) {
    Clipboard.setData(ClipboardData(text: text));
    showMessage(message ?? '复制成功');
  }

  Future<void> navToBrowser(String url) async {
    if (await canLaunch(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(url);
    } else {
      copy(url, message: '跳转url失败,链接已复制到剪贴板');
    }
  }

  // 跳转到浏览器
  Future<void> openLink(String url, {String urlYs = ''}) async {
    await urlToApp(url, urlYs);
  }

  /// url 跳转到 app  使用约束
  Future<void> urlToApp(String url, String urlYs) async {
    /// 如果是windows平台,直接跳转到浏览器打开链接
    if (GetPlatform.isWindows) {
      await launch(url);
      return;
    }
    var _url = url;
    _url = '$urlYs${urlHandle(url)}';
    print('app 约束跳转$_url');
    if (await canLaunch(_url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(_url);
    } else {
      if(await weChatBro){
        // 如果是微信浏览器
        if(await canLaunch(url)){
          await launch(url);
        }else{
          await launch(url.replaceAll('https://', ''));
        }
      }else{
        await launch(url);
      }
    }
  }

  // 打开淘宝
  Future<void> openTaobao(String url) async {
    await urlToApp(url, 'taobao://');
  }

  String urlHandle(String url) {
    var _url = url;
    if (_url.indexOf('http://') == 0) {
      _url = _url.replaceAll('http://', '');
    } else if (_url.indexOf('https://') == 0) {
      _url = _url.replaceAll('https://', '');
    }
    return _url;
  }

  /// 判断是否为微信浏览器
  Future<bool> get weChatBro => DdTaokeSdkWeb().isWeChatBrowser();
}

Utils get utils => GetIt.instance.get<Utils>();

