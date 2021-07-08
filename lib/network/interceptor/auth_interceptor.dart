import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sp_util/sp_util.dart';

class AuthInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = Hive.box('app').get('token');
    super.onRequest(options, handler);
  }
}