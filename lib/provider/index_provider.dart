import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:demo1/modals/params_model/store_params_model.dart';
import 'package:demo1/pages/index_page/model/store_list_model.dart';
import 'package:demo1/service/app_service.dart';
import 'package:demo1/util/color_util.dart';
import 'package:flutter/material.dart';

/// 首页状态管理
class IndexProvider with ChangeNotifier {
  Color topBackground = Colors.pinkAccent;
  List<Category> categorys = []; /// 超级分类列表
  List<Carousel> carousel = []; /// 轮播图展示列表
  StoreData? storeData; // 首页显示的品牌
  Map<int?,Color> brandBgColorMap = Map(); // 背景颜色

  /// 加载超级分类菜单
  Future<void> fetchCategorys() async {
    categorys.clear();
    final result = await DdTaokeSdk.instance.getCategorys();
    categorys.addAll(result);
    notifyListeners();
  }

  /// 获取首页的轮播图
  Future<void> fetchTopics() async {
    final result =  await DdTaokeSdk.instance.getCarousel();
    carousel.addAll(result);
    notifyListeners();
  }

  /// 获取品牌栏目列表
  Future<void> fetchStores() async {
    StoreData? _storeData = await IndexService.fetchStores(StoreListParamsModel(categorys[0].cid.toString(), "1", "10"));
    this.storeData = _storeData;
    this.getBrandBgColors();
    notifyListeners();
  }

  /// 改变顶部背景颜色
  Future<void> changeToColor(String netImageUrl) async {
    this.topBackground =await ColorUtil.getImageMainColor(netImageUrl);
    notifyListeners();
  }

  /// 获取品牌logo的主要背景颜色
  Future<void> getBrandBgColors ()async{
    if(storeData!=null){
      if(storeData!.lists!.isNotEmpty){
        for(StoreInfo info in storeData!.lists!){
          Color color = await ColorUtil.getImageMainColor(info.brandLogo!);
          brandBgColorMap[info.brandId] = color;
        }
        notifyListeners();
      }
    }
  }
}
