// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/product_list_param.dart';
import 'package:loading_more_list/loading_more_list.dart';

/// 首页商品列表
class IndexGoodsRepository extends LoadingMoreBase<Product> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  int pageSize = 50; // 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageindex = 1;
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    final result = await DdTaokeSdk.instance.getProducts(param: ProductListParam(pageId: '$pageindex',pageSize: '$pageSize'));
    if(result!=null){
      addAll(result.list??[]);
      pageindex++;
      isSuccess = true;
    }else{
      isSuccess = false;
    }
    return isSuccess;
  }
}
