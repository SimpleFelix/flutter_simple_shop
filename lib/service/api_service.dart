import 'package:dd_taoke_sdk/network/util.dart';
import 'package:demo1/common/toast.dart';
import 'package:get_it/get_it.dart';

class TKApiService {
  final _util = DdTaokeUtil();

  /// 美团领券
  Future<String> meituan(Map<String, String> data, {ResultDataMapHandle? mapHandle}) async {
    final result = await _util.get('/api/zhe/mt/tg', isTaokeApi: false, data: data, mapData: mapHandle,error: (int? code,String? message){
      if(message!=null){
        showToast(message);
      }
    });
    return result;
  }
}

TKApiService get tkApi => GetIt.I.get<TKApiService>();
