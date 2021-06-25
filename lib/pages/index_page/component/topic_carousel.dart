import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart' as my_carousel_comp;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/utils.dart';
import '../../../constant/style.dart';
import '../../../provider/index_provider.dart';

/// 首頁輪播圖
class IndexTopicComponentCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carousel = context.watch<IndexProvider>().carousel;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      height: 500.h,
      child: Stack(
        children: [
          my_carousel_comp.Carousel(
            images: carousel.map(renderItem).toList(),
            defaultImage: utils.widgetUtils.loading(double.infinity, 500.h),
            showIndicator: false,
            overlayShadowSize: 0.9,
            overlayShadow: true,
            overlayShadowColors: Colors.grey.shade200,
            animationCurve: Curves.easeOutQuart,
            onImageChange: (a,b){
              context.read<IndexProvider>().setCurrIndex(b+1);
            },
            autoplay: true,
          ),
          _renderIndexShow()
        ],
      ),
    );
  }

  Widget _renderIndexShow() {
    return Positioned(
        bottom: kDefaultPadding,
        right: kDefaultPadding,
        child: Consumer<IndexProvider>(
          builder: (BuildContext context, value, Widget? child) {
            final count = value.carousel.length;
            final curr = value.currIndex;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.17),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text('$curr/$count',style: TextStyle(
                color: Colors.white,
                fontSize: 55.sp
              ),),
            );
          },
        ));
  }

  Widget renderItem(Carousel item) {
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
  }

  CarouselSlider buildCarouselSlider(List<Carousel> carousel, BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 500.h,
          autoPlay: true,
          onPageChanged: (index, re) {
            final item = carousel[index];
            context.read<IndexProvider>().changeToColor(item.topicImage!);
          },
          enlargeCenterPage: true),
      items: carousel.map(renderItem).toList(),
    );
  }
}
