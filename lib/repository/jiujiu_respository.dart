import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/nine_nine_param.dart';
import 'package:loading_more_list/loading_more_list.dart';

/// 获取数据仓库
class JiuJiuRepository extends LoadingMoreBase<Product> {
  int pageIndex = 1; // 默认第一页
  bool _hasMore = true; // 是否还存在下一页
  String cid; // 类别ID
  bool forceRefresh = false;

  JiuJiuRepository(this.cid);

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    pageIndex = 1;
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false; // 是否加载成功

    final result =await DdTaokeSdk.instance.getNineNineProducts(param: NineNineParam(pageId: '$pageIndex',nineCid: '$cid',pageSize: '10'));

    if(result!=null){
      addAll(result.list??[]);
      isSuccess = true;
    }else{
      isSuccess = false;
    }

    _hasMore = result!=null && result.list!=null && result.list!.isNotEmpty;
    return isSuccess;
  }
}
