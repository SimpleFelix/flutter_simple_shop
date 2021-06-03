import 'package:demo1/pages/index_page/component/category_notification_stream.dart';
import 'package:demo1/pages/index_page/model/category_model.dart';
import 'package:demo1/provider/index_provider.dart';
import 'package:demo1/util/extended_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_item_layout.dart';

/// 通用分类插件
class CategoryComponent extends StatefulWidget {
  final List<InsetCustomItem>? extendItems;
  final SelectWithItem? onSelect;
  final TextStyle? textStyle;
  final TextStyle? currentStyle;
  final CategoryController? controller;

  const CategoryComponent(
      {Key? key, this.extendItems, this.onSelect, this.textStyle, this.controller, this.currentStyle})
      : super(key: key);

  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  int _current = 0;
  bool _isRenderEnd = false;
  CategoryChildPosition? _categoryChildPosition;
  final ValueNotifier<CategoryChildPosition?> _valueNotifier = ValueNotifier<CategoryChildPosition?>(
      CategoryChildPosition(count: 0, position: <int, Offset>{}, size: <int, Size>{}));

  @override
  void initState() {
    super.initState();
    _bindController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _isRenderEnd = true;
        _categoryChildPosition = CategoryChildPosition(count: 0, position: <int, Offset>{}, size: <int, Size>{});
      });
    });
    _valueNotifier.addListener(() {
      print('监听到改变:${_valueNotifier.value!.position![1]}');
    });
  }

  void _changePosition(int? index, Offset offset, Size? size) {
    _categoryChildPosition!.position![index!] = offset;
    _categoryChildPosition!.size![index] = size!;
    _valueNotifier.value = _categoryChildPosition;
  }

  @override
  void didUpdateWidget(covariant CategoryComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) _bindController();
  }

  /// 绑定控制器
  void _bindController() {
    if (widget.controller != null) widget.controller!.bindState(this);
  }

  @override
  Widget build(BuildContext context) {
    List<MainCategory> categorys = Provider.of<IndexProvider>(context).mainCategorys;
    int extendItemsLength = widget.extendItems == null ? 0 : widget.extendItems!.length;
    return Stack(
      children: [
        Container(
          height: 100.h,
          child: NotificationListener(
            onNotification: (dynamic notification){
              CategoryNotificationStreamUtil().notifiy(notification);
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  InsetCustomItem? insetCustomItem = _indexIsExtendWidget(index);
                  if (insetCustomItem != null) {
                    return GestureDetector(child: insetCustomItem.child, onTap: insetCustomItem.onTap as void Function()?);
                  } else {
                    MainCategory mainCategory = categorys[index - _getCountWhereInCategoryIndex(index)];
                    return GestureDetector(
                      child: CategoryItemDefaultLayout(
                        name: mainCategory.cname,
                        index: index,
                        textStyle: widget.textStyle,
                        current: _current,
                        onRendeEnd: _changePosition,
                      ),
                      onTap: () {
                        _onTap(mainCategory.cname, categorys);
                      },
                    );
                  }
                },
                itemCount: categorys.length + extendItemsLength,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ),
        _buildPoint()
      ],
    );
  }

  Widget _buildPoint() {
    final Offset? offset = _valueNotifier.value!.position![_current];
    final size = _valueNotifier.value!.size![_current];
    if(offset!=null&&size!=null) {
      print("组件大小:$size, 组件位置:$offset");
      final widgetWidth = size.width-50.w;
      return AnimatedPositioned(
          bottom: 0,
          left: offset.dx,
          child: Container(
            width: widgetWidth,
            height: 1.5,
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          duration: Duration(milliseconds: 700));
    }
    return Positioned(child: Container());
  }

  @override
  void dispose() {
    if (_valueNotifier.hasListeners) _valueNotifier.removeListener(() {});
    _valueNotifier.dispose();
    super.dispose();
  }

  /// 高亮选择项目
  void selectLable(int index) {
    setState(() {
      _current = index;
    });
  }

  /// 获取index前面有几个扩展的index
  int _getCountWhereInCategoryIndex(int index) {
    int count = 0;
    if (widget.extendItems != null && widget.extendItems!.isNotEmpty) {
      for (InsetCustomItem item in widget.extendItems!) {
        if (item.index! < index) {
          count++;
        } else {
          break;
        }
      }
    }
    return count;
  }

  /// 菜单被点击事件
  /// 不包含扩展项目
  void _onTap(String? name, List<MainCategory> categorys) {
    int _index = -1;
    MainCategory? _item;

    for (int i = 0; i < categorys.length; i++) {
      if (categorys[i].cname == name) {
        _index = i;
        _item = categorys[i];
        break;
      }
    }
    widget.onSelect!(_index, _item);
  }

  /// 判断下标是否需要插入自定义布局
  InsetCustomItem? _indexIsExtendWidget(int index) {
    InsetCustomItem? insetCustomItem;
    if (widget.extendItems != null) {
      for (int i = 0; i < widget.extendItems!.length; i++) {
        if (index == widget.extendItems![i].index) {
          insetCustomItem = widget.extendItems![i];
          break;
        }
      }
    }
    return insetCustomItem;
  }
}

class InsetCustomItem {
  /// 插入组件
  Widget? child;

  /// 点击事件
  Function? onTap;

  /// 插入位置
  int? index;

  InsetCustomItem({this.index, this.onTap, this.child});
}

/// 菜单项被选择
/// [index] 选择的下标
/// [item] 选择的菜单信息
typedef SelectWithItem = void Function(int index, MainCategory? item);

class CategoryController {
  late _CategoryComponentState _state;

  final int? current;

  CategoryController({this.current});

  void toIndex(int index) {
    _state.selectLable(index);
  }

  /// 绑定状态
  bindState(_CategoryComponentState _categoryComponentState) {
    this._state = _categoryComponentState;
  }
}

class CategoryChildPosition {
  int? count;
  Map<int, Offset>? position;
  Map<int, Size>? size;

  CategoryChildPosition({this.count, this.position, this.size});
}
