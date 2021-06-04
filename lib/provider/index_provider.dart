import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/params/brand_param.dart';
import 'package:demo1/util/color_util.dart';
import 'package:flutter/material.dart';

/// 首页状态管理
class IndexProvider with ChangeNotifier {
  Color topBackground = Colors.pinkAccent;
  List<Category> categorys = []; /// 超级分类列表
  List<Carousel> carousel = []; /// 轮播图展示列表
  BrandListResult? storeData; // 首页显示的品牌
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

    final result = await DdTaokeSdk.instance.getBrandList(param: BrandListParam(cid: categorys[0].cid.toString(), pageId: '1', pageSize: '1'));
    this.storeData = result;
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
        for(final info in storeData!.lists!){
          Color color = await ColorUtil.getImageMainColor(info.brandLogo!);
          brandBgColorMap[info.brandId] = color;
        }
        notifyListeners();
      }
    }
  }
}
