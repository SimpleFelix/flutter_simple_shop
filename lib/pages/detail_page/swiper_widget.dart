// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

// Project imports:
import '../../widgets/extended_image.dart';

class SwiperWidget extends StatelessWidget {
  final String images;
  SwiperWidget({required this.images});

  @override
  Widget build(BuildContext context) {
    List<String> imgArr;
    if (images != '') {
      imgArr = images.split(',');
      return Stack(
        children: <Widget>[
          Container(
            width: Get.width,
            height: Get.width,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ExtendedImageWidget(
                  height: 1440,
                  width: 1440,
                  fit: BoxFit.cover,
                  src: imgArr[index],
                );
              },
              itemCount: imgArr.length,
              pagination: SwiperPagination(),
            ),
          ),

          // 返回按钮
          Positioned(
              top: 20,
              left: 20,
              child: ClipOval(
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black26.withOpacity(0.8),
                    ),
                    child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }))),
              ))
        ],
      );
    }
    return Container();
  }
}
