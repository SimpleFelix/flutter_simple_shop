import '../../../modals/pdd_search_item_model.dart';

import 'package:get/get.dart';

import '../../../service/api_service.dart';

class SearchLogic extends GetxController {


  List<PddSearchItemModel> products = <PddSearchItemModel>[].obs; // 商品列表

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
