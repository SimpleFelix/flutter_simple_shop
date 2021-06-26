import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/index_grid_menu_item_model.dart';

/// 2020年11月17日 22:36:07
/// 首页的网格菜单
/// v2.0
class IndexGridViewMenu extends StatelessWidget {

  final IndexGridMenuItemModel model;

  const IndexGridViewMenu({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        switch(model.clickType){
          case IndexGridMenuItemModelClickModel.INNER_VIEW:
            model.onTap?.call();
            break;
          default:
            break;
        }
      },
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Expanded(child: Container(
              child: ExtendedImage.network(
                  '${model.iconUrl}',
                width: constraints.maxWidth,
                height: constraints.maxWidth,
              ),
            )),
            Text('${model.title}',style: TextStyle(fontSize: 50.sp))
          ],
        );
      },),
    );
  }
}
