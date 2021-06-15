import 'dart:convert';

import '../modals/Result.dart';

class ResultUtils {
  // 远程数据
  static Result format(res) {
    return Result.fromJson(json.decode(res.toString()));
  }
}
