import 'package:flutter/material.dart';

import '../../../util/image_util.dart';
import '../../../util/number_cover.dart';
import '../../../widgets/tag_widget.dart';
import '../models/brand_detail_model.dart';

/// 品牌信息卡片
class BrandDetail extends StatelessWidget {
  final BrandDetailModel? brandDetailModel;
  final Color bgColor;

  const BrandDetail(
      {Key? key, required this.brandDetailModel, required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _h = 150;
    return Container(
      height: _h,
      decoration: BoxDecoration(color: bgColor.withOpacity(.5)),
      child: Row(
        children: [
          _biuldLogo(context, _h),
          Expanded(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildName(context),_buildData(), _buildTag()],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildData(){
    return Container(
      child: Text('${Numeral(brandDetailModel!.fansNum!)}粉丝   ${Numeral(brandDetailModel!.sales!)}近期销量',style: TextStyle(
        color: Colors.white.withOpacity(.8),
        fontSize: 12
      ),),
    );
  }

  Widget _buildName(BuildContext context) {
    return Row(
      children: [
        Text(
          brandDetailModel!.brandName!,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 12,),
        InkWell(onTap: (){
          showInfo(context);
        },child: Icon(Icons.info_outline_rounded,color: Colors.white.withOpacity(.5),size: 15,),)
      ],
    );
  }

  Widget _buildTag() {
    return TagWidget2(
      tag: '${brandDetailModel!.brandFeatures}',
    );
  }

  Widget _biuldLogo(BuildContext context, double _h) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: _h * .8,
        height: _h * .8,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.network(
            MImageUtils.magesProcessor(brandDetailModel!.brandLogo!),
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void showInfo(BuildContext context){
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text('关于品牌'),
        content: Text(brandDetailModel!.brandDesc!),
      );
    });
  }
}
