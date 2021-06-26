import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';

class AuthInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = SpUtil.getString('token');
    super.onRequest(options, handler);
  }
}