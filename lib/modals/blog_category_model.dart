// Dart imports:
import 'dart:convert';

// Project imports:
import 'ff_convert_convert_util.dart';

class BlogCategory {
  BlogCategory({
    required this.id,
    required this.name,
    required this.logo,
    required this.intro,
    required this.createTime,
  });

  static List<BlogCategory> fromList(dynamic data) => List<BlogCategory>.from((data as List<dynamic>).map((e) => BlogCategory.fromJson(e)).toList());

  factory BlogCategory.fromJson(Map<String, dynamic> jsonRes) => BlogCategory(
    id: asT<int>(jsonRes['id'])!,
    name: asT<String>(jsonRes['name'])!,
    logo: asT<String>(jsonRes['logo'])!,
    intro: asT<String>(jsonRes['intro'])!,
    createTime: asT<int>(jsonRes['createTime'])!,
  );

  int id;
  String name;
  String logo;
  String intro;
  int createTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'logo': logo,
    'intro': intro,
    'createTime': createTime,
  };

  BlogCategory clone() => BlogCategory.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
