// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:extended_image/extended_image.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

// 在输入框渲染一张图片
class ImageText extends SpecialText {
  static const String flag = '<img';
  final int? start;
  @override
  final SpecialTextGestureTapCallback? onTap;

  ImageText(TextStyle textStyle, {this.start, this.onTap})
      : super(ImageText.flag, '/>', textStyle);
  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  @override
  InlineSpan finishText() {
    var text = '$flag${getContent()}>';
    var html = parse(text);
    var img = html.getElementsByTagName('img').first;
    var url = img.attributes['src']!;
    _imageUrl = url;

    var fit = BoxFit.cover;

    var pmWidth = Get.width;

    var height = double.tryParse(img.attributes['height']!)!;
    var width = double.tryParse(img.attributes['width']!)!;

    if (width > pmWidth) {
      var bl = pmWidth / pmWidth;
      height = height * bl;
      width = pmWidth;
    }

    return ExtendedWidgetSpan(
        start: start!,
        actualText: text,
        child: Container(
          width: pmWidth,
          child: Center(
            child: GestureDetector(
                onTap: () {
                  onTap?.call(url);
                },
                child: ExtendedImage.network(url,
                    width: width,
                    height: height,
                    fit: fit,
                    loadStateChanged: loadStateChanged)),
          ),
        ));
  }

  Widget? loadStateChanged(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Container(
          color: Colors.grey,
        );
      case LoadState.completed:
        return null;
      case LoadState.failed:
        state.imageProvider.evict();
        return GestureDetector(
          onTap: () {
            state.reLoadImage();
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                'assets/failed.jpg',
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Text(
                  '图片加载失败,点击重试',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
    }
  }
}
