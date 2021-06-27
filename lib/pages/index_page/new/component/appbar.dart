import 'package:dd_taoke_sdk/model/category.dart';
import 'package:demo1/provider/riverpod/category_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndexHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const IndexHomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: CupertinoSearchTextField(
        placeholder: '搜索商品,标题',
        placeholderStyle: TextStyle(fontSize: 13, color: Colors.grey),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.message,color: Colors.black,))
      ],
      leading: Container(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset('assets/svg/diandian.svg',width: 34,height: 34,),
      ),
      leadingWidth: 45,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: DefaultTabController(
          length: 1+context.read(categoryRiverpod).categorys.length,
          child: Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: '精选',),
                ...renderCategorys(context)
              ],
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> renderCategorys(BuildContext context){
    return context.read(categoryRiverpod).categorys.map((e) => Tab(text: e.cname,)).toList();
  }

  @override
  Size get preferredSize => Size.fromHeight(48*2);
}
