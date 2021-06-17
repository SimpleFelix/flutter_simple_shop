import 'package:carousel_slider/carousel_slider.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../../../provider/index_provider.dart';

/// 首頁輪播圖
class IndexTopicComponentCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carousel = context.watch<IndexProvider>().carousel;
    return CarouselSlider(
      options: CarouselOptions(height: 500.h,autoPlay: true,onPageChanged: (index,re){
        final item = carousel[index];
        context.read<IndexProvider>().changeToColor(item.topicImage!);
      },enlargeCenterPage: true),
      items: carousel.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return ExtendedImage.network(
              item.topicImage!,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.all(Radius.circular(50.sp)),
              shape: BoxShape.rectangle,
            );
          },
        );
      }).toList(),
    );
  }

  Container _old(List<Carousel> carousel, BuildContext context) {
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
        final item = carousel[index];
        Provider.of<IndexProvider>(context, listen: false).changeToColor(item.topicImage!);
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
