import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:dd_taoke_sdk/params/brand_param.dart';
import 'package:demo1/modals/params_model/store_detail_params_model.dart';
import 'package:demo1/pages/brand_page/models/brand_detail_model.dart';
import 'package:demo1/service/app_service.dart';
import 'package:demo1/util/color_util.dart';
import 'package:flutter/material.dart';

class BrandProvider extends ChangeNotifier {
  int page = 1;
  int size = 10;
  String cid = "";
  List<ListElement> lists = [];
  String brandId = "";
  int pageId = 1;
  int pageSize = 20;
  BrandDetailModel? brandDetailModel;
  List<BrandDetailGoodsList> brandGoodsList = [];
  Color detailBgColor = Colors.white;

  void setCid(String _cid) => this.cid = _cid;

  /// 加载品牌列表
  Future<void> refresh() async {
    lists.clear();
    page = 1;
   final result = await  DdTaokeSdk.instance.getBrandList(param: BrandListParam(cid: '$cid', pageId: '$page', pageSize: '$size'));
    if (result != null) {
      lists.addAll(result.lists??[]);
    }
    notifyListeners();
  }

  /// 加载下一页
  Future<void> load() async {
    this.page = this.page + 1;
    print("正在加载下一页:$page");
    final result = await  DdTaokeSdk.instance.getBrandList(param: BrandListParam(cid: '$cid', pageId: '$page', pageSize: '$size'));
    if (result != null) {
      lists.addAll(result.lists??[]);
    }
    notifyListeners();
  }

  /// 加载品牌页面
  /// 首次
  Future<void> detail(String _brandId) async {
    this.brandId = _brandId;
    StoreDetailParamsModel storeDetailParamsModel =
        StoreDetailParamsModel(_brandId, "$pageSize", "$pageId");
    BrandDetailModel? brandDetailModel =
        await IndexService.fetchStoreDetail(storeDetailParamsModel);
    if (brandDetailModel != null) {
      this.detailBgColor =
          await ColorUtil.getImageMainColor(brandDetailModel.brandLogo!);
      this.brandGoodsList.addAll(brandDetailModel.list!);
      this.brandDetailModel = brandDetailModel;
    }
    notifyListeners();
  }

  // 返回值表示是否还有下一页
  Future<bool> detailNextPage()async{
    this.pageId = this.pageId = 1;
    StoreDetailParamsModel storeDetailParamsModel =
    StoreDetailParamsModel(this.brandId, "$pageSize", "$pageId");
    BrandDetailModel? brandDetailModel =
    await IndexService.fetchStoreDetail(storeDetailParamsModel);
    if(brandDetailModel!=null){
      this.brandGoodsList.addAll(brandDetailModel.list!);
      notifyListeners();
      if(brandDetailModel.list!.length!=this.pageSize){
        return false;
      }
      return true;
    }
    notifyListeners();
    return false;
  }

  void emptyDetail() {
    this.brandDetailModel = null;
    this.brandGoodsList.clear();
  }
}
