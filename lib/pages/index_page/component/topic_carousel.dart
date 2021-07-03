import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart' as my_carousel_comp;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../../../common/utils.dart';
import '../../../constant/style.dart';
import '../../../provider/index_provider.dart';

/// 首頁輪播圖
class IndexTopicComponentCarousel extends StatelessWidget {

  final List<Carousel> list;

  const IndexTopicComponentCarousel({Key? key,required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: AspectRatio(
        aspectRatio: 2.53,
        child: Swiper(itemBuilder: (BuildContext context, int index) {
          final item = list[index];
          return renderItem(item);
        }, itemCount: list.length,
          pagination: SwiperPagination(),

        ),
      ),
    );
  }


  Widget render(){
    return my_carousel_comp.Carousel(
      images: list.map(renderItem).toList(),
      defaultImage: utils.widgetUtils.loading(double.infinity, 500.h),
      overlayShadow: true,
      dotSpacing: 12,
      indicatorBgPadding: 1,
      overlayShadowColors: Colors.grey.shade200,
      animationCurve: Curves.easeOutQuart,
      radius: Radius.circular(5),
      dotVerticalPadding: 5,
      dotSize: 5,
      onImageChange: (a,b){
      },
      onImageTap: (index){
        final clickItem = list[index];
        print('点击;${jsonEncode(clickItem)}');
        if(clickItem.link!=null){
          utils.openLink(clickItem.link!);
        }

      },

      autoplay: true,
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
          borderRadius: BorderRadius.all(Radius.circular(5)),
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
          enlargeCenterPage: true),
      items: carousel.map(renderItem).toList(),
    );
  }
}
