import 'package:dd_taoke_sdk/model/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../util/result_obj_util.dart';
import '../util/request_service.dart';
import '../modals/Result.dart';

class NineGoodsProvider with ChangeNotifier {

  List<Product>? goods = [];
  String currentNineCid = "-1";
  int page = 1;

}
