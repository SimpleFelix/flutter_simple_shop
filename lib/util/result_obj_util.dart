// Dart imports:
import 'dart:convert';

// Project imports:
import '../modals/result.dart';

class ResultUtils {
  // 远程数据
  static Result format(res) {
    return Result.fromJson(json.decode(res.toString()));
  }
}
