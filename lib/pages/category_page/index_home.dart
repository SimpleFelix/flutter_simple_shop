import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

import './left_widget.dart';
import './right_widget.dart';
import '../../provider/riverpod/category_riverpod.dart';
import '../../widgets/edit_page_handle.dart';

class CategoryIndexPage extends StatefulWidget {
  @override
  _CategoryIndexPageState createState() => _CategoryIndexPageState();
}

class _CategoryIndexPageState extends State<CategoryIndexPage> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '分类',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(42),
          child: Container(
              margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: Center(
                  child: CupertinoSearchTextField(
                placeholder: '关键字搜索',
                placeholderStyle: TextStyle(fontSize: 13, color: Colors.grey),
              ))),
        ),
      ),
      body: EditePageHandle(
        child: Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final categorys = watch(categoryRiverpod).categorys;
            final current = watch(categoryRiverpod).current;
            if (categorys.isEmpty) {
              return Container(
                child: Text('没有数据'),
              );
            }
            return Container(
                margin: EdgeInsets.only(top: 12),
                width: MediaQuery.of(context).size.width,
                height: Get.height - kToolbarHeight - Get.mediaQuery.padding.top,
                child: Row(
                  children: <Widget>[
                    //左侧
                    Container(
                      width: ScreenUtil().setWidth(300),
                      color: Color.fromRGBO(248, 248, 248, 1.0),
                      child: ListView.builder(
                          itemCount: categorys.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => context.read(categoryRiverpod).setCurrent(categorys[index]),
                              child: LeftWidgetItem(item: categorys[index], isCurrent: current.cid == categorys[index].cid),
                            );
                          }),
                    ),

                    //右侧
                    Expanded(
                      child: Container(
                          color: Colors.white,
                          child: WaterfallFlow.builder(
                            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 20),
                            itemBuilder: (context, sIndex) {
                              return RightWidgetItme(category: current, item: current.subcategories![sIndex]);
                            },
                            itemCount: (current.subcategories ?? []).length,
                          )),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
