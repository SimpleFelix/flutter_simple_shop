import 'package:loading_more_list/loading_more_list.dart';

import '../../../modals/pdd_product.dart';
import '../../../service/api_service.dart';

class PddRecommendListResp extends LoadingMoreBase<PddGoods> {
  int pageindex = 0;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      final list = await tkApi.pddRecommendGoods(pageindex, 1);
      addAll(pddCovertList(list));
      pageindex++;
      _hasMore = list.length == 20;
    } catch (e, s) {
      print('转换失败');
      print(e);
      print(s);
    }

    return true;
  }

  @override
  bool get hasMore => _hasMore;
}
