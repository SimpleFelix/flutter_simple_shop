import 'package:after_layout/after_layout.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/brand_detail_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/brand_product_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_widget.dart';
import 'components/detail_brand_info.dart';
import 'components/detail_product_list.dart';
import 'provider/brand_provider.dart';

// 产品品牌详情页面
class BrandDetailPage extends StatefulWidget {
  final String brandId;

  const BrandDetailPage({Key? key, required this.brandId}) : super(key: key);

  @override
  _BrandDetailPageState createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends State<BrandDetailPage> with AfterLayoutMixin<BrandDetailPage> {
  BrandProvider? _brandProvider;
  final EasyRefreshController _easyRefreshController = EasyRefreshController();
  List<Product> products = <Product>[];
  BrandDetail? brandDetailModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _brandProvider ??= Provider.of<BrandProvider>(context);
  }

  Widget _buildBody() {
    return EasyRefresh.custom(
      slivers: [
        SliverToBoxAdapter(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: brandDetailModel == null
                ? LoadingWidget()
                : BrandDetailView(
                    brandDetailModel: brandDetailModel!, bgColor: _brandProvider!.detailBgColor),
          ),
        ),
        DetailProductList(
          list: products,
        )
      ],
      controller: _easyRefreshController,
      onLoad: load,
    );
  }

  // 下一页列表
  Future<void> load() async {
    _easyRefreshController.callLoad();
    var hasNextPage = await _brandProvider!.detailNextPage();
    _easyRefreshController.finishLoad(noMore: !hasNextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('品牌详情'),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    final result = await DdTaokeSdk.instance.getBrandDetail(
        param: BrandProductParam(brandId: widget.brandId, pageId: '1', pageSize: '20'));
    if (result != null) {
      products.addAll(result.list ?? []);
    }
    brandDetailModel = result;
    _setState();
  }

  void _setState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _brandProvider!.emptyDetail();
    super.dispose();
  }
}
