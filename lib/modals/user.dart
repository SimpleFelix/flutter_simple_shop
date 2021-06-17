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
      final valueS = value.toString();
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
    this.email,
    required this.picture,
     this.phone,
    required this.password,
    this.loginTime,
    this.type,
    required this.enabled,
    this.authorities,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.accountNonExpired,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> jsonRes) => User(
    id: asT<int>(jsonRes['id'])!,
    loginNumber: asT<String>(jsonRes['loginNumber'])!,
    nickName: asT<String>(jsonRes['nickName'])!,
    email: asT<Object?>(jsonRes['email']),
    picture: asT<String>(jsonRes['picture'])!,
    phone: asT<String?>(jsonRes['phone']),
    password: asT<String>(jsonRes['password'])!,
    loginTime: asT<Object?>(jsonRes['loginTime']),
    type: asT<int?>(jsonRes['type']),
    enabled: asT<bool>(jsonRes['enabled'])!,
    authorities: asT<Object?>(jsonRes['authorities']),
    accountNonLocked: asT<bool>(jsonRes['accountNonLocked'])!,
    credentialsNonExpired: asT<bool>(jsonRes['credentialsNonExpired'])!,
    accountNonExpired: asT<bool>(jsonRes['accountNonExpired'])!,
    username: asT<String?>(jsonRes['username']),
  );

  int id;
  String loginNumber;
  String nickName;
  Object? email;
  String picture;
  String? phone;
  String password;
  Object? loginTime;
  int? type;
  bool enabled;
  Object? authorities;
  bool accountNonLocked;
  bool credentialsNonExpired;
  bool accountNonExpired;
  String? username;

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
    'enabled': enabled,
    'authorities': authorities,
    'accountNonLocked': accountNonLocked,
    'credentialsNonExpired': credentialsNonExpired,
    'accountNonExpired': accountNonExpired,
    'username': username,
  };

  User clone() =>
      User.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
