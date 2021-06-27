import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:demo1/pages/index_page/component/topic_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final carouselRiverpod = FutureProvider<List<Carousel>>((ref) async {
  final result = await DdTaokeSdk.instance.getCarousel();
  return result;
});

class IndexCarousel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final carousel = useProvider(carouselRiverpod);
    return SliverToBoxAdapter(
      child: carousel.when(
          data: (data) => IndexTopicComponentCarousel(
                list: data,
              ),
          loading: () => Container(),
          error: (_, __) => Text('加载轮播图失败')),
    );
  }
}
