import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart' as my_carousel_comp;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:dd_taoke_sdk/params/activity_link_param.dart';
import 'package:demo1/pages/activity_page/activity_view/view.dart';
import 'package:demo1/pages/index_page/new/index_riverpod.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils.dart';
import '../../../constant/style.dart';
import '../../../provider/index_provider.dart';

/// 首頁輪播圖
class IndexTopicComponentCarousel extends StatelessWidget {
  final List<Carousel> list;

  const IndexTopicComponentCarousel({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: AspectRatio(
        aspectRatio: 2.53,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            final item = list[index];
            return renderItem(item);
          },
          itemCount: list.length,
          pagination: SwiperPagination(),
          onTap: (int index) async {
            final item = list[index];
            print(jsonEncode(item));
            if(item.sourceType==1){
              await context.navigator.push(SwipeablePageRoute(builder: (_)=> ActivityViewPage(id: '${item.topicId!}',title: item.topicName!,)));
            }
            if(item.sourceType==2){
              Get.context!.read(indexRiverpod).changeLoadingState(true);
              final result =  await DdTaokeSdk.instance.getActivityLink(ActivityLinkParam(promotionSceneId: item.activityId!));
              if(result!=null){
                await utils.openTaobao(result.clickUrl);
              }
              Get.context!.read(indexRiverpod).changeLoadingState(false);
            }
            if ((item.link??'').isNotEmpty) {
              print(item.link);
              await utils.openLink(item.link!);
            }
          },
        ),
      ),
    );
  }

  Widget render() {
    return my_carousel_comp.Carousel(
      images: list.map(renderItem).toList(),
      defaultImage: utils.widgetUtils.loading(double.infinity, 200),
      overlayShadow: true,
      dotSpacing: 12,
      indicatorBgPadding: 1,
      overlayShadowColors: Colors.grey.shade200,
      animationCurve: Curves.easeOutQuart,
      radius: Radius.circular(5),
      dotVerticalPadding: 5,
      dotSize: 5,
      onImageChange: (a, b) {},
      onImageTap: (index) {
        final clickItem = list[index];
        print('点击;${jsonEncode(clickItem)}');
        if (clickItem.link != null) {
          utils.openLink(clickItem.link!);
        }
      },
      autoplay: true,
    );
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
      options: CarouselOptions(height: 200, autoPlay: true, enlargeCenterPage: true),
      items: carousel.map(renderItem).toList(),
    );
  }
}
