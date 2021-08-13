// Dart imports:

// Package imports:
import 'package:loading_more_list/loading_more_list.dart';

import '../modals/order_list_model.dart';
// Project imports:
import '../util/user_utils.dart';

class OrderRespository extends LoadingMoreBase<OrderAuditObject>{

  int pageIndex = 1; // 默认第一页
  bool _hasMore = true; // 是否还存在下一页
  bool forceRefresh = false;

  String stype; // 类别ID
  OrderRespository({this.stype ='-1'});
  
  @override
  // TODO: implement hasMore
  bool get hasMore => _hasMore;
  
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    
    var isSuccess = false;
    
    await UserUtil.loadUserInfo().then((user) async {
      if(user!=null){
      }else{
        print('请先登录');
      }
    });
    
    return isSuccess;
  }


  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    pageIndex = 1;
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

}
