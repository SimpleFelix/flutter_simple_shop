import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constant/style.dart';


class AppTitle extends StatelessWidget {
  final String text;
  const AppTitle({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Text(text,style: Get.textTheme.headline6!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 78.sp
      ),),
    );
  }
}
