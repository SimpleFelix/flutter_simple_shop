import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common/utils.dart';
import '../../../constant/style.dart';
import '../../../provider/user_provider.dart';

// 用户登入页面
class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  bool isAgree = false; // 是否同意协议
  String username = ''; // 用户名
  String password = ''; // 密码
  bool loading = false; // 是否登录中

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text('注册账号',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                //   Logo
                Container(
                  child: Center(
                    child: Container(
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(200),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Image.asset('assets/images/logo.png')),
                  ),
                ),

                // 间隔
                SizedBox(height: 40),

                //表单

                Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      // 用户名输入框
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '手机号/邮箱',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),

                      // 密码输入框
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '密码',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      )
                    ],
                  ),
                ),

                // 间隔
                SizedBox(height: 40),
                Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child:
                        ElevatedButton(onPressed: _submit, child: Text('登录')))
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            child: Container(
              width: ScreenUtil().setWidth(1440),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          isAgree = !isAgree;
                        });
                      },
                      child: Image.asset(
                        isAgree
                            ? 'assets/icons/select.png'
                            : 'assets/icons/select_no.png',
                        height: ScreenUtil().setHeight(58),
                        width: ScreenUtil().setWidth(58),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: FSuper(
                        lightOrientation: FLightOrientation.LeftBottom,
                        text: '我已阅读并同意',
                        spans: [
                          TextSpan(
                              text: '用户协议',
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: '和', style: TextStyle()),
                          TextSpan(
                              text: '隐私政策',
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 登录
  Future<void> _submit() async {
    if (username.isEmpty || password.isEmpty) {
      utils.showMessage('请输入用户名或者密码');
      return;
    }
    var isLoginSuccess =
        await context.read<UserProvider>().login(username, password);
    if (isLoginSuccess) {
      Navigator.pop(context);
    }
    setState(() {
      loading = false;
    });
  }
}
