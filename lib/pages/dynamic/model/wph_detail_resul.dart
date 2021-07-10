import 'dart:convert';
import '../../../modals/ff_convert_convert_util.dart';

class WeipinhuiDetail {
  WeipinhuiDetail({
    required this.returnCode,
    required this.result,
  });

  factory WeipinhuiDetail.fromJson(Map<String, dynamic> jsonRes) {
    final result =
    jsonRes['result'] is List ? <WeipinhuiResult>[] : <WeipinhuiResult>[];
    for (final dynamic item in jsonRes['result']!) {
      if (item != null) {
        tryCatch(() {
          result.add(
              WeipinhuiResult.fromJson(asT<Map<String, dynamic>>(item)!));
        });
      }
    }
    return WeipinhuiDetail(
      returnCode: asT<String>(jsonRes['returnCode'])!,
      result: result,
    );
  }

  String returnCode;
  List<WeipinhuiResult> result;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'returnCode': returnCode,
    'result': result,
  };

  WeipinhuiDetail clone() => WeipinhuiDetail.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class WeipinhuiResult {
  WeipinhuiResult({
    required this.marketPrice,
    required this.commissionRate,
    required this.goodsId,
    required this.discount,
    required this.goodsCarouselPictures,
    required this.goodsDetailPictures,
    required this.categoryName,
    required this.haiTao,
    required this.prepayInfo,
    required this.cat2ndName,
    required this.cat1stName,
    required this.vipPrice,
    required this.commission,
    required this.cat1stId,
    required this.goodsName,
    required this.storeServiceCapability,
    required this.brandName,
    required this.brandLogoFull,
    required this.couponInfo,
    required this.brandStoreSn,
    required this.sellTimeFrom,
    required this.schemeStartTime,
    required this.commentsInfo,
    required this.saleStockStatus,
    required this.schemeEndTime,
    required this.sourceType,
    required this.sellTimeTo,
    required this.brandId,
    required this.goodsThumbUrl,
    required this.cat2ndId,
    required this.spuId,
    required this.storeInfo,
    required this.goodsMainPicture,
    required this.destUrl,
    required this.categoryId,
    required this.status,
  });

  factory WeipinhuiResult.fromJson(Map<String, dynamic> jsonRes) {
    final goodsCarouselPictures =
    jsonRes['goodsCarouselPictures'] is List ? <String>[] :  <String>[];
    for (final dynamic item in jsonRes['goodsCarouselPictures']!) {
      if (item != null) {
        tryCatch(() {
          goodsCarouselPictures.add(asT<String>(item)!);
        });
      }
    }

    final goodsDetailPictures =
    jsonRes['goodsDetailPictures'] is List ? <String>[] : null;
    if (goodsDetailPictures != null) {
      for (final dynamic item in jsonRes['goodsDetailPictures']!) {
        if (item != null) {
          tryCatch(() {
            goodsDetailPictures.add(asT<String>(item)!);
          });
        }
      }
    }
    return WeipinhuiResult(
      marketPrice: asT<String>(jsonRes['marketPrice'])!,
      commissionRate: asT<String>(jsonRes['commissionRate'])!,
      goodsId: asT<String>(jsonRes['goodsId'])!,
      discount: asT<String>(jsonRes['discount'])!,
      goodsCarouselPictures: goodsCarouselPictures,
      goodsDetailPictures: goodsDetailPictures!,
      categoryName: asT<String>(jsonRes['categoryName'])!,
      haiTao: asT<int>(jsonRes['haiTao'])!,
      prepayInfo: PrepayInfo.fromJson(
          asT<Map<String, dynamic>>(jsonRes['prepayInfo'])!),
      cat2ndName: asT<String>(jsonRes['cat2ndName'])!,
      cat1stName: asT<String>(jsonRes['cat1stName'])!,
      vipPrice: asT<String>(jsonRes['vipPrice'])!,
      commission: asT<String>(jsonRes['commission'])!,
      cat1stId: asT<int>(jsonRes['cat1stId'])!,
      goodsName: asT<String>(jsonRes['goodsName'])!,
      storeServiceCapability: StoreServiceCapability.fromJson(
          asT<Map<String, dynamic>>(jsonRes['storeServiceCapability'])!),
      brandName: asT<String>(jsonRes['brandName'])!,
      brandLogoFull: asT<String>(jsonRes['brandLogoFull'])!,
      couponInfo: CouponInfo.fromJson(
          asT<Map<String, dynamic>>(jsonRes['couponInfo'])!),
      brandStoreSn: asT<String>(jsonRes['brandStoreSn'])!,
      sellTimeFrom: asT<int>(jsonRes['sellTimeFrom'])!,
      schemeStartTime: asT<int>(jsonRes['schemeStartTime'])!,
      commentsInfo: CommentsInfo.fromJson(
          asT<Map<String, dynamic>>(jsonRes['commentsInfo'])!),
      saleStockStatus: asT<int>(jsonRes['saleStockStatus'])!,
      schemeEndTime: asT<int>(jsonRes['schemeEndTime'])!,
      sourceType: asT<int>(jsonRes['sourceType'])!,
      sellTimeTo: asT<int>(jsonRes['sellTimeTo'])!,
      brandId: asT<int>(jsonRes['brandId'])!,
      goodsThumbUrl: asT<String>(jsonRes['goodsThumbUrl'])!,
      cat2ndId: asT<int>(jsonRes['cat2ndId'])!,
      spuId: asT<String>(jsonRes['spuId'])!,
      storeInfo:
      StoreInfo.fromJson(asT<Map<String, dynamic>>(jsonRes['storeInfo'])!),
      goodsMainPicture: asT<String>(jsonRes['goodsMainPicture'])!,
      destUrl: asT<String>(jsonRes['destUrl'])!,
      categoryId: asT<int>(jsonRes['categoryId'])!,
      status: asT<int>(jsonRes['status'])!,
    );
  }

  String marketPrice;
  String commissionRate;
  String goodsId;
  String discount;
  List<String> goodsCarouselPictures;
  List<String> goodsDetailPictures;
  String categoryName;
  int haiTao;
  PrepayInfo prepayInfo;
  String cat2ndName;
  String cat1stName;
  String vipPrice;
  String commission;
  int cat1stId;
  String goodsName;
  StoreServiceCapability storeServiceCapability;
  String brandName;
  String brandLogoFull;
  CouponInfo couponInfo;
  String brandStoreSn;
  int sellTimeFrom;
  int schemeStartTime;
  CommentsInfo commentsInfo;
  int saleStockStatus;
  int schemeEndTime;
  int sourceType;
  int sellTimeTo;
  int brandId;
  String goodsThumbUrl;
  int cat2ndId;
  String spuId;
  StoreInfo storeInfo;
  String goodsMainPicture;
  String destUrl;
  int categoryId;
  int status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'marketPrice': marketPrice,
    'commissionRate': commissionRate,
    'goodsId': goodsId,
    'discount': discount,
    'goodsCarouselPictures': goodsCarouselPictures,
    'goodsDetailPictures': goodsDetailPictures,
    'categoryName': categoryName,
    'haiTao': haiTao,
    'prepayInfo': prepayInfo,
    'cat2ndName': cat2ndName,
    'cat1stName': cat1stName,
    'vipPrice': vipPrice,
    'commission': commission,
    'cat1stId': cat1stId,
    'goodsName': goodsName,
    'storeServiceCapability': storeServiceCapability,
    'brandName': brandName,
    'brandLogoFull': brandLogoFull,
    'couponInfo': couponInfo,
    'brandStoreSn': brandStoreSn,
    'sellTimeFrom': sellTimeFrom,
    'schemeStartTime': schemeStartTime,
    'commentsInfo': commentsInfo,
    'saleStockStatus': saleStockStatus,
    'schemeEndTime': schemeEndTime,
    'sourceType': sourceType,
    'sellTimeTo': sellTimeTo,
    'brandId': brandId,
    'goodsThumbUrl': goodsThumbUrl,
    'cat2ndId': cat2ndId,
    'spuId': spuId,
    'storeInfo': storeInfo,
    'goodsMainPicture': goodsMainPicture,
    'destUrl': destUrl,
    'categoryId': categoryId,
    'status': status,
  };

  WeipinhuiResult clone() => WeipinhuiResult.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class PrepayInfo {
  PrepayInfo({
    required this.isPrepay,
  });

  factory PrepayInfo.fromJson(Map<String, dynamic> jsonRes) => PrepayInfo(
    isPrepay: asT<int>(jsonRes['isPrepay'])!,
  );

  int isPrepay;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'isPrepay': isPrepay,
  };

  PrepayInfo clone() => PrepayInfo.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class StoreServiceCapability {
  StoreServiceCapability({
    required this.storeScore,
    required this.storeRankRate,
  });

  factory StoreServiceCapability.fromJson(Map<String, dynamic> jsonRes) =>
      StoreServiceCapability(
        storeScore: asT<String>(jsonRes['storeScore'])!,
        storeRankRate: asT<String>(jsonRes['storeRankRate'])!,
      );

  String storeScore;
  String storeRankRate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'storeScore': storeScore,
    'storeRankRate': storeRankRate,
  };

  StoreServiceCapability clone() => StoreServiceCapability.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class CouponInfo {
  CouponInfo({
    required this.useEndTime,
    required this.totalAmount,
    required this.couponName,
    required this.activateEndTime,
    required this.buy,
    required this.useBeginTime,
    required this.couponNo,
    required this.fav,
    required this.activateBeginTime,
    required this.activedAmount,
  });

  factory CouponInfo.fromJson(Map<String, dynamic> jsonRes) => CouponInfo(
    useEndTime: asT<int>(jsonRes['useEndTime'])!,
    totalAmount: asT<int>(jsonRes['totalAmount'])!,
    couponName: asT<String>(jsonRes['couponName'])!,
    activateEndTime: asT<int>(jsonRes['activateEndTime'])!,
    buy: asT<String>(jsonRes['buy'])!,
    useBeginTime: asT<int>(jsonRes['useBeginTime'])!,
    couponNo: asT<String>(jsonRes['couponNo'])!,
    fav: asT<String>(jsonRes['fav'])!,
    activateBeginTime: asT<int>(jsonRes['activateBeginTime'])!,
    activedAmount: asT<int>(jsonRes['activedAmount'])!,
  );

  int useEndTime;
  int totalAmount;
  String couponName;
  int activateEndTime;
  String buy;
  int useBeginTime;
  String couponNo;
  String fav;
  int activateBeginTime;
  int activedAmount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'useEndTime': useEndTime,
    'totalAmount': totalAmount,
    'couponName': couponName,
    'activateEndTime': activateEndTime,
    'buy': buy,
    'useBeginTime': useBeginTime,
    'couponNo': couponNo,
    'fav': fav,
    'activateBeginTime': activateBeginTime,
    'activedAmount': activedAmount,
  };

  CouponInfo clone() => CouponInfo.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class CommentsInfo {
  CommentsInfo({
    required this.comments,
    required this.goodCommentsShare,
  });

  factory CommentsInfo.fromJson(Map<String, dynamic> jsonRes) => CommentsInfo(
    comments: asT<int>(jsonRes['comments'])!,
    goodCommentsShare: asT<String>(jsonRes['goodCommentsShare'])!,
  );

  int comments;
  String goodCommentsShare;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'comments': comments,
    'goodCommentsShare': goodCommentsShare,
  };

  CommentsInfo clone() => CommentsInfo.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class StoreInfo {
  StoreInfo({
    required this.storeName,
    required this.storeId,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> jsonRes) => StoreInfo(
    storeName: asT<String>(jsonRes['storeName'])!,
    storeId: asT<String>(jsonRes['storeId'])!,
  );

  String storeName;
  String storeId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'storeName': storeName,
    'storeId': storeId,
  };

  StoreInfo clone() => StoreInfo.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
