import 'package:flutter/material.dart';

import 'components/appbar.dart';

/// 首页
/// 桌面版本
class IndexHomeV2 extends StatelessWidget {
  const IndexHomeV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndexAppbarWithDesktop(),
    );
  }
}
