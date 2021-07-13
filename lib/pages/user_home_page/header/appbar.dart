import 'package:demo1/common/utils.dart';
import 'package:demo1/pages/user_home_page/scan/scan_code_auth.dart';
import 'package:demo1/pages/user_home_page/scan/scan_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class UserHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        '个人中心',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              final scanData = await ScanLayout.doScan();
              if(scanData.isNotEmpty){
                print('扫描到数据:$scanData');
               final isOk = await utils.userApi.checkIsUuid(scanData);
               if(isOk){
                 await Get.to(()=>ScanCodeAuth(
                   uuid: scanData,
                 ));
               }
              }
            },
            icon: Icon(
              Icons.qr_code,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            )),
        utils.widgetUtils.marginRight()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
