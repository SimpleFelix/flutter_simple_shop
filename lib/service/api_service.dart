import 'package:dd_taoke_sdk/network/util.dart';
import 'package:get_it/get_it.dart';

import '../common/toast.dart';
import '../common/utils.dart';

class TKApiService {
  /// 美团领券
  Future<String> meituan(Map<String, String> data, {ResultDataMapHandle? mapHandle}) async {
    final result = await utils.api.get('/api/zhe/mt/tg', data: data, mapHandle: mapHandle, error: (int? code, String? message) {
      if (message != null) {
        showToast(message);
      }
    });
    return result;
  }

  /// 设置最新版本号
  /// 需要登录
  /// 需要有admin权限
  Future<void> setNewVersionNumber(String number,String desc,String url) async {
    final result = await utils.api.post('/api/admin/set-last-version', {'version': number,'desc':desc,'url':url});
    utils.showMessage(result);
  }

  /// 获取服务器最新的版本号
  Future<String> getLastVersion() async {
    return await utils.api.get('/api/version/last-version');
  }
}

TKApiService get tkApi => GetIt.I.get<TKApiService>();
