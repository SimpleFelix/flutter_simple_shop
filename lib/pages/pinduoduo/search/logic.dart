import 'package:get/get.dart';

import '../../../service/api_service.dart';
import 'model.dart';

class SearchLogic extends GetxController {


  List<PddDetail> products = <PddDetail>[].obs; // 商品列表

  /// 执行搜索
  void onSearch(String chats) {
    products.clear();
    tkApi.pddSearch(chats).then((value) {
      print('搜索到拼多多商品:${value.length}条');
      products.addAll(value);
      update();
    });

  }
}
