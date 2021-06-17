import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common/utils.dart';
import '../../fluro/navigator_util.dart';
import '../../provider/user_provider.dart';
import '../../util/system_toast.dart';
import '../../util/user_utils.dart';
import 'header/appbar.dart';
import 'header/index.dart';
import 'order/index.dart';
import 'widgets/list_item.dart';

/// 用户主页布局
class UserIndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<UserIndexHome> {
  UserProvider? userProvider;

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
            Container(
              child: Column(
                children: <Widget>[
                  ListItem(
                    title: '订单绑定',
                    onTap: () async {
                      await UserUtil.loadUserInfo().then((user) {
                        if (user != null) {
                          NavigatorUtil.gotoOrderAddIndexPage(context);
                        } else {
                          SystemToast.show('请先登录');
                        }
                      });
                    },
                    isCard: true,
                  ),
                  ListItem(
                    title: '帮助反馈',
                    onTap: () {
                      print('前往帮助反馈页面');
                    },
                    isCard: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Get.dialog(AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('发布博客'),
                    leading: Icon(Icons.insert_drive_file_outlined),
                    onTap: (){
                      Get.back();
                      NavigatorUtil.goetoWhitePage(context);
                    },
                  ),
                  ListTile(
                    title: Text('发布动态'),
                    leading: Icon(Icons.app_registration),
                    onTap: (){

                    },
                  ),
                ],
              ),
            ),
          ));
        },
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }

  Widget _buildHeaderWidget() {

    return HeaderIndex();
  }

  @override
  void didChangeDependencies() {
    var userProvider = Provider.of<UserProvider>(context);
    if (this.userProvider != userProvider) {
      this.userProvider = userProvider;
    }
    super.didChangeDependencies();
  }
}
