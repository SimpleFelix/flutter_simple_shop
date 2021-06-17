import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo1/provider/index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

/// 精选专题首页轮播
class IndexTopicComponentCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carousel = context.watch<IndexProvider>().carousel;
    return Container(
      height: 500.h,
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: Swiper(
        autoplay: carousel.isNotEmpty,
        duration: 1000,
        loop: true,
        onTap: (int index) async {
        },
        onIndexChanged: (index) {
          if (carousel.isNotEmpty) {
            Future.delayed(Duration(seconds: 0), () {
              final item = carousel[index];
              Provider.of<IndexProvider>(context, listen: false).changeToColor(item.topicImage!);
            });
          }
        },
        itemBuilder: (BuildContext context, int index) {
          final item = carousel[index];
          return ExtendedImage.network(
            item.topicImage!,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.all(Radius.circular(50.sp)),
            shape: BoxShape.rectangle,
          );
        },
        itemCount: carousel.length,
        pagination: SwiperPagination(),
        // viewportFraction: 0.8,
        // scale: 0.9,
      ),
    );
  }
}
