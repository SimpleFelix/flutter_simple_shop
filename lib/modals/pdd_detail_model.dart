import 'dart:convert';
import 'dart:developer';

import 'ff_convert_convert_util.dart';


class PddDetail {
  PddDetail({
    required this.activityPromotionRate,
    required this.activityTags,
    required this.brandName,
    required this.catIds,
    required this.couponDiscount,
    required this.couponEndTime,
    required this.couponMinOrderAmount,
    required this.couponRemainQuantity,
    required this.couponStartTime,
    required this.couponTotalQuantity,
    required this.descTxt,
    required this.extraCouponAmount,
    required this.goodsDesc,
    required this.goodsGalleryUrls,
    required this.goodsImageUrl,
    required this.goodsName,
    required this.goodsSign,
    required this.goodsThumbnailUrl,
    required this.hasCoupon,
    required this.hasMallCoupon,
    required this.lgstTxt,
    required this.mallCouponDiscountPct,
    required this.mallCouponEndTime,
    required this.mallCouponMaxDiscountAmount,
    required this.mallCouponMinOrderAmount,
    required this.mallCouponRemainQuantity,
    required this.mallCouponStartTime,
    required this.mallCouponTotalQuantity,
    required this.mallCps,
    required this.mallId,
    required this.mallImgUrl,
    required this.mallName,
    required this.merchantType,
    required this.minGroupPrice,
    required this.minNormalPrice,
    required this.onlySceneAuth,
    required this.optId,
    required this.optIds,
    required this.optName,
    required this.planType,
    required this.predictPromotionRate,
    required this.promotionRate,
    required this.salesTip,
    required this.serviceTags,
    required this.servTxt,
    required this.shareRate,
    required this.subsidyAmount,
    required this.subsidyDuoAmountTenMillion,
    required this.unifiedTags,
    required this.videoUrls,
    required this.zsDuoId,
  });

  factory PddDetail.fromJson(Map<String, dynamic> jsonRes) {
    final List<int>? activityTags =
    jsonRes['activity_tags'] is List ? <int>[] : null;
    if (activityTags != null) {
      for (final dynamic item in jsonRes['activity_tags']!) {
        if (item != null) {
          tryCatch(() {
            activityTags.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<int>? catIds = jsonRes['cat_ids'] is List ? <int>[] : null;
    if (catIds != null) {
      for (final dynamic item in jsonRes['cat_ids']!) {
        if (item != null) {
          tryCatch(() {
            catIds.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<String>? goodsGalleryUrls =
    jsonRes['goods_gallery_urls'] is List ? <String>[] : null;
    if (goodsGalleryUrls != null) {
      for (final dynamic item in jsonRes['goods_gallery_urls']!) {
        if (item != null) {
          tryCatch(() {
            goodsGalleryUrls.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<int>? optIds = jsonRes['opt_ids'] is List ? <int>[] : null;
    if (optIds != null) {
      for (final dynamic item in jsonRes['opt_ids']!) {
        if (item != null) {
          tryCatch(() {
            optIds.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<int>? serviceTags =
    jsonRes['service_tags'] is List ? <int>[] : null;
    if (serviceTags != null) {
      for (final dynamic item in jsonRes['service_tags']!) {
        if (item != null) {
          tryCatch(() {
            serviceTags.add(asT<int>(item)!);
          });
        }
      }
    }

    final List<String>? unifiedTags =
    jsonRes['unified_tags'] is List ? <String>[] : null;
    if (unifiedTags != null) {
      for (final dynamic item in jsonRes['unified_tags']!) {
        if (item != null) {
          tryCatch(() {
            unifiedTags.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<Object>? videoUrls =
    jsonRes['video_urls'] is List ? <Object>[] : null;
    if (videoUrls != null) {
      for (final dynamic item in jsonRes['video_urls']!) {
        if (item != null) {
          tryCatch(() {
            videoUrls.add(asT<Object>(item)!);
          });
        }
      }
    }
    return PddDetail(
      activityPromotionRate: asT<int>(jsonRes['activity_promotion_rate'])!,
      activityTags: activityTags!,
      brandName: asT<String>(jsonRes['brand_name'])!,
      catIds: catIds!,
      couponDiscount: asT<int>(jsonRes['coupon_discount'])!,
      couponEndTime: asT<int>(jsonRes['coupon_end_time'])!,
      couponMinOrderAmount: asT<int>(jsonRes['coupon_min_order_amount'])!,
      couponRemainQuantity: asT<int>(jsonRes['coupon_remain_quantity'])!,
      couponStartTime: asT<int>(jsonRes['coupon_start_time'])!,
      couponTotalQuantity: asT<int>(jsonRes['coupon_total_quantity'])!,
      descTxt: asT<String>(jsonRes['desc_txt'])!,
      extraCouponAmount: asT<int>(jsonRes['extra_coupon_amount'])!,
      goodsDesc: asT<String>(jsonRes['goods_desc'])!,
      goodsGalleryUrls: goodsGalleryUrls!,
      goodsImageUrl: asT<String>(jsonRes['goods_image_url'])!,
      goodsName: asT<String>(jsonRes['goods_name'])!,
      goodsSign: asT<String>(jsonRes['goods_sign'])!,
      goodsThumbnailUrl: asT<String>(jsonRes['goods_thumbnail_url'])!,
      hasCoupon: asT<bool>(jsonRes['has_coupon'])!,
      hasMallCoupon: asT<bool>(jsonRes['has_mall_coupon'])!,
      lgstTxt: asT<String>(jsonRes['lgst_txt'])!,
      mallCouponDiscountPct: asT<int>(jsonRes['mall_coupon_discount_pct'])!,
      mallCouponEndTime: asT<int>(jsonRes['mall_coupon_end_time'])!,
      mallCouponMaxDiscountAmount:
      asT<int>(jsonRes['mall_coupon_max_discount_amount'])!,
      mallCouponMinOrderAmount:
      asT<int>(jsonRes['mall_coupon_min_order_amount'])!,
      mallCouponRemainQuantity:
      asT<int>(jsonRes['mall_coupon_remain_quantity'])!,
      mallCouponStartTime: asT<int>(jsonRes['mall_coupon_start_time'])!,
      mallCouponTotalQuantity: asT<int>(jsonRes['mall_coupon_total_quantity'])!,
      mallCps: asT<int>(jsonRes['mall_cps'])!,
      mallId: asT<int>(jsonRes['mall_id'])!,
      mallImgUrl: asT<String>(jsonRes['mall_img_url'])!,
      mallName: asT<String>(jsonRes['mall_name'])!,
      merchantType: asT<int>(jsonRes['merchant_type'])!,
      minGroupPrice: asT<int>(jsonRes['min_group_price'])!,
      minNormalPrice: asT<int>(jsonRes['min_normal_price'])!,
      onlySceneAuth: asT<bool>(jsonRes['only_scene_auth'])!,
      optId: asT<int>(jsonRes['opt_id'])!,
      optIds: optIds!,
      optName: asT<String>(jsonRes['opt_name'])!,
      planType: asT<int>(jsonRes['plan_type'])!,
      predictPromotionRate: asT<int>(jsonRes['predict_promotion_rate'])!,
      promotionRate: asT<int>(jsonRes['promotion_rate'])!,
      salesTip: asT<String>(jsonRes['sales_tip'])!,
      serviceTags: serviceTags!,
      servTxt: asT<String>(jsonRes['serv_txt'])!,
      shareRate: asT<int>(jsonRes['share_rate'])!,
      subsidyAmount: asT<int>(jsonRes['subsidy_amount'])!,
      subsidyDuoAmountTenMillion:
      asT<int>(jsonRes['subsidy_duo_amount_ten_million'])!,
      unifiedTags: unifiedTags!,
      videoUrls: videoUrls!,
      zsDuoId: asT<int>(jsonRes['zs_duo_id'])!,
    );
  }

  int activityPromotionRate;
  List<int> activityTags;
  String brandName;
  List<int> catIds;
  int couponDiscount;
  int couponEndTime;
  int couponMinOrderAmount;
  int couponRemainQuantity;
  int couponStartTime;
  int couponTotalQuantity;
  String descTxt;
  int extraCouponAmount;
  String goodsDesc;
  List<String> goodsGalleryUrls;
  String goodsImageUrl;
  String goodsName;
  String goodsSign;
  String goodsThumbnailUrl;
  bool hasCoupon;
  bool hasMallCoupon;
  String lgstTxt;
  int mallCouponDiscountPct;
  int mallCouponEndTime;
  int mallCouponMaxDiscountAmount;
  int mallCouponMinOrderAmount;
  int mallCouponRemainQuantity;
  int mallCouponStartTime;
  int mallCouponTotalQuantity;
  int mallCps;
  int mallId;
  String mallImgUrl;
  String mallName;
  int merchantType;
  int minGroupPrice;
  int minNormalPrice;
  bool onlySceneAuth;
  int optId;
  List<int> optIds;
  String optName;
  int planType;
  int predictPromotionRate;
  int promotionRate;
  String salesTip;
  List<int> serviceTags;
  String servTxt;
  int shareRate;
  int subsidyAmount;
  int subsidyDuoAmountTenMillion;
  List<String> unifiedTags;
  List<Object> videoUrls;
  int zsDuoId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'activity_promotion_rate': activityPromotionRate,
    'activity_tags': activityTags,
    'brand_name': brandName,
    'cat_ids': catIds,
    'coupon_discount': couponDiscount,
    'coupon_end_time': couponEndTime,
    'coupon_min_order_amount': couponMinOrderAmount,
    'coupon_remain_quantity': couponRemainQuantity,
    'coupon_start_time': couponStartTime,
    'coupon_total_quantity': couponTotalQuantity,
    'desc_txt': descTxt,
    'extra_coupon_amount': extraCouponAmount,
    'goods_desc': goodsDesc,
    'goods_gallery_urls': goodsGalleryUrls,
    'goods_image_url': goodsImageUrl,
    'goods_name': goodsName,
    'goods_sign': goodsSign,
    'goods_thumbnail_url': goodsThumbnailUrl,
    'has_coupon': hasCoupon,
    'has_mall_coupon': hasMallCoupon,
    'lgst_txt': lgstTxt,
    'mall_coupon_discount_pct': mallCouponDiscountPct,
    'mall_coupon_end_time': mallCouponEndTime,
    'mall_coupon_max_discount_amount': mallCouponMaxDiscountAmount,
    'mall_coupon_min_order_amount': mallCouponMinOrderAmount,
    'mall_coupon_remain_quantity': mallCouponRemainQuantity,
    'mall_coupon_start_time': mallCouponStartTime,
    'mall_coupon_total_quantity': mallCouponTotalQuantity,
    'mall_cps': mallCps,
    'mall_id': mallId,
    'mall_img_url': mallImgUrl,
    'mall_name': mallName,
    'merchant_type': merchantType,
    'min_group_price': minGroupPrice,
    'min_normal_price': minNormalPrice,
    'only_scene_auth': onlySceneAuth,
    'opt_id': optId,
    'opt_ids': optIds,
    'opt_name': optName,
    'plan_type': planType,
    'predict_promotion_rate': predictPromotionRate,
    'promotion_rate': promotionRate,
    'sales_tip': salesTip,
    'service_tags': serviceTags,
    'serv_txt': servTxt,
    'share_rate': shareRate,
    'subsidy_amount': subsidyAmount,
    'subsidy_duo_amount_ten_million': subsidyDuoAmountTenMillion,
    'unified_tags': unifiedTags,
    'video_urls': videoUrls,
    'zs_duo_id': zsDuoId,
  };

  PddDetail clone() =>
      PddDetail.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
