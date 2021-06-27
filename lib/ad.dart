import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'app.dart';
import 'controller/app_controller.dart';
import 'provider/riverpod/category_riverpod.dart';

class AdPage extends StatefulWidget {
  const AdPage({Key? key}) : super(key: key);

  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final bg = AppController.find.bgBytes.value;
        return Stack(
          children: [
            if(bg!=null)
              Positioned(left:0,top:0,child: Image.memory(bg,width: Get.width,height: Get.height,fit: BoxFit.cover,)),
            Center(
              child: ShowUpAnimation(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('欢迎来到典典的小卖部',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                    SizedBox(height: 20),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            ),
          ],
        );
      })
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await context.read(categoryRiverpod).init();
    await Get.off(()=>App());
  }
}
