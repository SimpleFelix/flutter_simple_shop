import 'package:demo1/pages/index_page/new/component/gridmenu/menu_item.dart';
import 'package:demo1/pages/index_page/new/component/gridmenu/model.dart';
import 'package:demo1/pages/user_home_page/pages/new_version_page.dart';
import 'package:demo1/provider/riverpod/user_riverpod.dart';
import 'package:demo1/widgets/wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/utils.dart';
import 'header/appbar.dart';
import 'header/index.dart';
import 'order/index.dart';

/// 用户主页布局
class UserIndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<UserIndexHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserHomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeaderWidget(),
            utils.widgetUtils.marginTop(),
            OrderIndex(),
            utils.widgetUtils.marginTop(),
            Consumer(
              builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
                final hasAdminAuth = watch(userModel).hasAdminAuthority();
                if (!hasAdminAuth) return Container();
                return MyWrap(
                  title: '管理员功能',
                  children: [
                    GridMenuItem(
                        item: GridMenuModel(
                            title: '新版本',
                            image: 'assets/svg/new_version.svg',
                            onTap: () {
                              utils.widgetUtils.to(NewVersionPage());
                            },
                            isAssets: true))
                  ],
                );
              },
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.edit,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      //   onPressed: () {
      //     Get.dialog(AlertDialog(
      //       contentPadding: EdgeInsets.zero,
      //       content: SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             ListTile(
      //               title: Text('发布博客'),
      //               leading: Icon(Icons.insert_drive_file_outlined),
      //               onTap: (){
      //                 Get.back();
      //                 NavigatorUtil.goetoWhitePage(context);
      //               },
      //             ),
      //             ListTile(
      //               title: Text('发布动态'),
      //               leading: Icon(Icons.app_registration),
      //               onTap: (){
      //
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ));
      //   },
      //   backgroundColor: Colors.pinkAccent,
      // ),
    );
  }

  Widget _buildHeaderWidget() {
    return HeaderIndex();
  }
}
