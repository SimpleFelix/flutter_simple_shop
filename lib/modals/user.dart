import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class User {
  User({
    required this.id,
    required this.loginNumber,
    required this.nickName,
    required this.email,
    required this.picture,
    required this.phone,
    required this.password,
    required this.loginTime,
    required this.type,
    required this.roles,
    required this.resourcesCategories,
    required this.status,
    required this.salt,
  });

  factory User.fromJson(Map<String, dynamic> jsonRes) {
    final List<Roles>? roles = jsonRes['roles'] is List ? <Roles>[] : null;
    if (roles != null) {
      for (final dynamic item in jsonRes['roles']!) {
        if (item != null) {
          tryCatch(() {
            roles.add(Roles.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Object>? resourcesCategories =
    jsonRes['resourcesCategories'] is List ? <Object>[] : null;
    if (resourcesCategories != null) {
      for (final dynamic item in jsonRes['resourcesCategories']!) {
        if (item != null) {
          tryCatch(() {
            resourcesCategories.add(asT<Object>(item)!);
          });
        }
      }
    }
    return User(
      id: asT<int>(jsonRes['id'])!,
      loginNumber: asT<String>(jsonRes['loginNumber'])!,
      nickName: asT<String>(jsonRes['nickName'])!,
      email: asT<Object>(jsonRes['email'])!,
      picture: asT<String>(jsonRes['picture'])!,
      phone: asT<Object>(jsonRes['phone'])!,
      password: asT<String>(jsonRes['password'])!,
      loginTime: asT<Object>(jsonRes['loginTime'])!,
      type: asT<int>(jsonRes['type'])!,
      roles: roles!,
      resourcesCategories: resourcesCategories!,
      status: asT<int>(jsonRes['status'])!,
      salt: asT<String>(jsonRes['salt'])!,
    );
  }

  int id;
  String loginNumber;
  String nickName;
  Object email;
  String picture;
  Object phone;
  String password;
  Object loginTime;
  int type;
  List<Roles> roles;
  List<Object> resourcesCategories;
  int status;
  String salt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'loginNumber': loginNumber,
    'nickName': nickName,
    'email': email,
    'picture': picture,
    'phone': phone,
    'password': password,
    'loginTime': loginTime,
    'type': type,
    'roles': roles,
    'resourcesCategories': resourcesCategories,
    'status': status,
    'salt': salt,
  };

  User clone() =>
      User.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Roles {
  Roles({
    required this.id,
    required this.name,
    required this.description,
    required this.createDate,
    required this.status,
    required this.roleSort,
  });

  factory Roles.fromJson(Map<String, dynamic> jsonRes) => Roles(
    id: asT<int>(jsonRes['id'])!,
    name: asT<String>(jsonRes['name'])!,
    description: asT<String>(jsonRes['description'])!,
    createDate: asT<int>(jsonRes['createDate'])!,
    status: asT<int>(jsonRes['status'])!,
    roleSort: asT<int>(jsonRes['roleSort'])!,
  );

  int id;
  String name;
  String description;
  int createDate;
  int status;
  int roleSort;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'description': description,
    'createDate': createDate,
    'status': status,
    'roleSort': roleSort,
  };

  Roles clone() =>
      Roles.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
