import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils.dart';
import '../../../constant/style.dart';
import '../../../provider/riverpod/user_riverpod.dart';

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
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text('注册账号', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //   Logo
                renderLogo(),

                // 间隔
                SizedBox(height: 40),

                //表单
                Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: <Widget>[
                      // 用户名输入框
                      TextField(
                        decoration: InputDecoration(
                          hintText: '请输入登录账号',
                          labelText: '账号',
                        ),
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),

                      utils.widgetUtils.marginTop(),
                      // 密码输入框
                      TextField(
                        decoration: InputDecoration(
                          hintText: '请输入登录密码',
                          labelText: '密码',
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
                renderLoginButton()
              ],
            ),
          ),
          // renderXieyi()
        ],
      ),
    );
  }

  Widget renderLoginButton() {
    return FButton(
      width: 200,
      text: '登 录',
      style: TextStyle(color: Colors.white),
      color: Colors.pink,
      onPressed: _submit,
      clickEffect: true,
      alignment: Alignment.center,
      padding: EdgeInsets.all(kDefaultPadding),
      corner: FCorner.all(50),
      highlightColor: Colors.pinkAccent.withOpacity(0.50),
      hoverColor: Colors.pink.withOpacity(0.76),
    );
  }

  // 协议
  Widget renderXieyi() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
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
              isAgree ? 'assets/icons/select.png' : 'assets/icons/select_no.png',
              height: 22,
              width:22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FSuper(
              lightOrientation: FLightOrientation.LeftBottom,
              text: '我已阅读并同意',
              spans: [
                TextSpan(text: '用户协议', style: TextStyle(decoration: TextDecoration.underline)),
                TextSpan(text: '和', style: TextStyle()),
                TextSpan(text: '隐私政策', style: TextStyle(decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 顶部logo
  Widget renderLogo() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 12),
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
              ),
              Positioned(
                left: 0,
                top: 0,
                child: SvgPicture.asset(
                  'assets/svg/diandian.svg',
                  width: 80,
                  height: 80,
                  color: Colors.pink,
                ),
              )
            ],
          )),
    );
  }

  /// 登录
  Future<void> _submit() async {
    if (username.isEmpty || password.isEmpty) {
      utils.showMessage('请输入用户名或者密码');
      return;
    }
    var isLoginSuccess = await context.read(userModel).login(username, password);
    if (isLoginSuccess) {
      Get.back();
    }
    setState(() {
      loading = false;
    });
  }
}
