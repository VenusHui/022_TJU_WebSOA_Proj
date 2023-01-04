// 登录请求体
class UserLoginRequestEntity {
  String user_name;
  String password;

  UserLoginRequestEntity({
    required this.user_name,
    required this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        user_name: json["user_name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": user_name,
        "password": password,
      };
}

/// 用户实体类
class User {
  late String? accid;
  late String? token;
  late String? nickname;
  String? ccid;
  int? gender;
  String? birth;
  String? avatar;
  String? sign;

  User(
      {this.accid,
      this.token,
      this.ccid,
      this.gender,
      this.birth,
      this.sign,
      this.avatar});

  static User fromMap(Map<String, dynamic> map) {
    User user = User();
    user.accid = map['accid'];
    user.token = map['token'];
    user.nickname = map['nickname'];
    user.ccid = map['ccid'];
    user.gender = map['gender'];
    user.birth = map['birth'];
    user.avatar = map['avatar'];
    if (map.containsKey("sign")) {
      user.sign = map['sign'];
    }

    return user;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'accid': accid,
      'token': token,
    };
    return map;
  }
}
