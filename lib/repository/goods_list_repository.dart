// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/product_list_param.dart';
import 'package:loading_more_list/loading_more_list.dart';

class GoodsListRepository extends LoadingMoreBase<Product> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  int pageSize = 50; // 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200

  //外面传进来的参数
  String? sortStr;
  String? brand;
  String? cids;
  String? subcid;

  GoodsListRepository({this.sortStr, this.brand, this.cids, this.subcid});

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
    var isSuccess = false;
    print('正在获取第$pageindex页数据,排序:$sortStr,品牌:$brand,主类目:$cids,子类目:$subcid');

    final result = await DdTaokeSdk.instance.getProducts(
        param: ProductListParam(
            pageId: '$pageindex',
            sort: '$sortStr',
            brand: '$brand',
            cids: '$cids',
            subcid: '$subcid'));

    if (result != null) {
      addAll(result.list ?? []);
      isSuccess = true;
    } else {
      isSuccess = false;
    }

    return isSuccess;
  }
}
