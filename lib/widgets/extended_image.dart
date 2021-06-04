import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import '../util/image_util.dart';
import 'component/custom_loading.dart';

// 图像扩展组件
class ExtendedImageWidget extends StatelessWidget {
  final String src;
  final double height;
  final double width;
  final BorderRadius radius;
  final BoxFit fit;
  final bool knowSize;

  ExtendedImageWidget({
    required this.src,
    required this.height,
    required this.width,
    this.radius: BorderRadius.zero,
    this.fit: BoxFit.fill,
    this.knowSize: true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: buildExtendedImage(w: width, h: height));
  }

  Widget buildExtendedImage({double? w, double? h}) {
    Widget image = Stack(
      children: <Widget>[
        ExtendedImage.network(
          MImageUtils.magesProcessor(src),
          fit: fit,
          width: width,
          height: height,
          borderRadius: radius,
          shape: BoxShape.rectangle,
          clearMemoryCacheWhenDispose: true,
          cache: true,
          enableLoadState: true,
          loadStateChanged: loadingState,
        )
      ],
    );

    return image;
  }
}
