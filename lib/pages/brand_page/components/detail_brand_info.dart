import 'package:dd_taoke_sdk/model/brand_detail_result.dart';
import 'package:demo1/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/image_util.dart';
import '../../../util/number_cover.dart';
import '../../../widgets/tag_widget.dart';

/// 品牌信息卡片
class BrandDetailView extends StatelessWidget {
  final BrandDetail brandDetailModel;
  final Color bgColor;

  const BrandDetailView(
      {Key? key, required this.brandDetailModel, required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _biuldLogo(),
          utils.widgetUtils.marginTop(),
          Text(brandDetailModel.brandDesc!)
        ],
      ),
    );
  }

  Widget _buildData(){
    return Container(
      child: Text('${Numeral(brandDetailModel.fansNum!)}粉丝   ${Numeral(brandDetailModel.sales!)}近期销量',style: TextStyle(
        color: Colors.black.withOpacity(.8),
        fontSize: 12
      ),),
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          brandDetailModel.brandName!,
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 12,),
        InkWell(onTap: (){
          showInfo();
        },child: Icon(Icons.info_outline_rounded,color: Colors.black.withOpacity(.5),size: 15,),)
      ],
    );
  }

  Widget _buildTag() {
    return TagWidget2(
      tag: '${brandDetailModel.brandFeatures}',
    );
  }

  Widget _biuldLogo() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200)
          ),
          child: Image.network(
            MImageUtils.magesProcessor(brandDetailModel.brandLogo!),
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 12,),
        _buildName()
      ],
    );
  }

  void showInfo(){
    showDialog(context: Get.context!,builder: (context){
      return AlertDialog(
        title: Text('关于品牌'),
        content: Text(brandDetailModel.brandDesc!),
      );
    });
  }
}
