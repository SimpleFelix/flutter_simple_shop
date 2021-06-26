import 'package:demo1/widgets/edit_page_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';

import './left_widget.dart';
import './right_widget.dart';
import '../../provider/category_provider.dart';
import '../../provider/index_provider.dart';

class CategoryIndexPage extends StatefulWidget {
  @override
  _CategoryIndexPageState createState() => _CategoryIndexPageState();
}

class _CategoryIndexPageState extends State<CategoryIndexPage> {
  CategoryProvider? categoryProvider;

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<IndexProvider>(
      builder: (context, categoryProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '分类',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(42),
              child:
                  Container(
                    margin: EdgeInsets.only(bottom: 12,left: 12,right: 12),
                      child: Center(child: CupertinoSearchTextField(placeholder: '关键字搜索',placeholderStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade200
                      ),))),
            ),
          ),
          body: EditePageHandle(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: Get.height - kToolbarHeight - Get.mediaQuery.padding.top,
                child: categoryProvider.categorys.isNotEmpty
                    ? Row(
                        children: <Widget>[
                          //左侧
                          Container(
                            width: ScreenUtil().setWidth(300),
                            color: Color.fromRGBO(248, 248, 248, 1.0),
                            child: ListView.builder(
                                itemCount: categoryProvider.categorys.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                      });
                                    },
                                    child: LeftWidgetItem(
                                        item: categoryProvider.categorys[index],
                                        isCurrent: current == index),
                                  );
                                }),
                          ),

                          //右侧
                          Expanded(
                            child: Container(
                                color: Colors.white,
                                child: WaterfallFlow.builder(
                                  gridDelegate:
                                      SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, sIndex) {
                                    return RightWidgetItme(
                                        cid: categoryProvider
                                            .categorys[current].cid
                                            .toString(),
                                        item: categoryProvider.categorys[current]
                                            .subcategories![sIndex]);
                                  },
                                  itemCount: (categoryProvider
                                              .categorys[current].subcategories ??
                                          [])
                                      .length,
                                )),
                          )
                        ],
                      )
                    : Container()),
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var categoryProvider = Provider.of<CategoryProvider>(context);
    if (this.categoryProvider != categoryProvider) {
      this.categoryProvider = categoryProvider;
      //  转到在pages/index_page/index_home 调用
//      categoryProvider.loadDtkCategoryDatas(context);
    }
  }
}
