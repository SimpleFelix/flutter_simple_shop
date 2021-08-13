// Package imports:
import 'package:dio/dio.dart';


class UserApi {

  /// 检测是否存在于redius数据库中
  Future<bool> checkIsUuid(String uuid) async {
    final response = await Dio().get<bool>('http://192.168.199.64/api/has-uuid',queryParameters: {
      'uuid':uuid
    });
    if(response.statusCode==200){
      return response.data ?? false;
    }
    return false;
  }

  /// 设置token信息
  Future<bool> setToken(String uuid,String token) async {
    final response = await Dio().get<bool>('http://192.168.199.64/api/set-uuid-token',queryParameters: {
      'uuid':uuid,
      'userToken':token
    });
    if(response.statusCode==200){
      return response.data ?? false;
    }
    return false;
  }
}
