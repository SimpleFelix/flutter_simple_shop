import 'package:demo1/common/widget_util.dart';
import 'package:get_it/get_it.dart';

/// 工具类
class Utils {
  static WidgetUtils get widgetUtils => GetIt.instance.get<WidgetUtils>();
}

Utils get utils => GetIt.instance.get<Utils>();
