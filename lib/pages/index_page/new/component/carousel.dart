// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/carousel_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supercharged/supercharged.dart';

// Project imports:
import 'package:demo1/pages/index_page/component/topic_carousel.dart';
import 'package:demo1/widgets/component/custom_loading.dart';

final carouselRiverpod = FutureProvider<List<Carousel>>((ref) async {

  await 3.seconds.delay;
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
          loading: () => Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: AspectRatio(
                  aspectRatio: 2.53,
                  child: Skeleton(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
          ),
          error: (_, __) => Text('加载轮播图失败')),
    );
  }
}
