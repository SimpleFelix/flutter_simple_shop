// Package imports:
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';

//前端页面访问本地域名
const String LocalHost = 'localhost';

//前端页面访问本地端口号
const int LocalPort = 8088;

//目标域名，这里咱们将要请求火狐的这个地址
const String TargetUrl = 'http://localhost';

Future main() async {
  var server = await shelf_io.serve(
    proxyHandler(TargetUrl),
    LocalHost,
    LocalPort,
  );
  // 添加上跨域的这几个header

  print('Serving at http://${server.address.host}:${server.port}');
}
