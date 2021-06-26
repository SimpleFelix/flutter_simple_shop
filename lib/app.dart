import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import './pages/category_page/index_home.dart';
import './pages/favorite_page/index_home.dart';
import './pages/index_page/index_home.dart';
import './pages/jiujiu_page/index_home.dart';
import './pages/user_home_page/index_home.dart';
import './personal/personal.dart';
import 'provider/user_provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  UserProvider? userProvider;
  static ScrollController mController = ScrollController();
  static ScrollController jiujiuController = ScrollController(); // 9.9包邮页面滑动控制器

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  var _currentIndex = 0; //当前选中页面索引

  IndexHome? indexHome; // 淘客首页

  CategoryIndexPage? categoryIndexPage; // 分类页面

  //我的页面
  Personal? me;

  //是否加载中
  bool isLoading = false;

  bool isShowAppBar = true;

  // 页面列表
  final List<Widget> _pages = [
    IndexHome(),
    // IndexHomeV2(),
    JiujiuIndexHome(scrollController: jiujiuController),
    CategoryIndexPage(),
    FavoriteIndexHome(),
    UserIndexHome()
  ];

  Widget loadingWidget() {
    return Center(
      child: SpinKitCircle(
        color: Colors.blue,
        size: 30.0,
      ),
    );
  }


  @override
  void initState() {
//监听滚动事件，打印滚动位置
    mController.addListener(() {
      if (mController.offset < 250 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (mController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });

    // 9.9滑动控制器操作
    jiujiuController.addListener(() {
      if (jiujiuController.offset < 250 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (jiujiuController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配初始化
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1440, 2940),
        orientation: Orientation.portrait);
    return Scaffold(
      // 滚动到顶部按钮
      floatingActionButton: !showToTopBtn ||
              _currentIndex == 2 ||
              _currentIndex == 3 ||
              _currentIndex == 0 ||
              _currentIndex == 4
          ? null
          : FloatingActionButton(
              onPressed: () {
                //返回到顶部时执行动画
                if (_currentIndex == 0) {
                  mController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }
                if (_currentIndex == 1) {
                  jiujiuController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }
              },
              child: Icon(Icons.arrow_upward, color: Colors.white)),
      bottomNavigationBar:  BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //当前页面索引
          currentIndex: _currentIndex,
          //按下后设置当前页面索引
          onTap: ((index) {
            setState(() {
              _currentIndex = index;
            });
          }),
          items: [
             BottomNavigationBarItem(
                label: '首页',
                icon: _currentIndex == 0
                    ? Image.asset(
                        'assets/nav/home.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/home-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
             BottomNavigationBarItem(
                label: '9.9包邮',
                icon: _currentIndex == 1
                    ? Image.asset(
                        'assets/nav/jiujiu.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/jiujiu-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
             BottomNavigationBarItem(
                label: '分类',
                icon: _currentIndex == 2
                    ? Image.asset(
                        'assets/nav/fenlei.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/fenlei-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
             BottomNavigationBarItem(
                label: '收藏',
                icon: _currentIndex == 3
                    ? Image.asset(
                        'assets/nav/shoucang.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/shoucang-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
             BottomNavigationBarItem(
                label: '我的',
                icon: _currentIndex == 4
                    ? Image.asset(
                        'assets/nav/my.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/my-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
          ]),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
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
