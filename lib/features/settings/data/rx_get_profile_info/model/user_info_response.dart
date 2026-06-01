import 'dart:convert';

class UserInfoResponse {
  bool? status;
  String? message;
  int? code;
  Data? data;

  UserInfoResponse({this.status, this.message, this.code, this.data});

  UserInfoResponse copyWith({
    bool? status,
    String? message,
    int? code,
    Data? data,
  }) => UserInfoResponse(
    status: status ?? this.status,
    message: message ?? this.message,
    code: code ?? this.code,
    data: data ?? this.data,
  );

  factory UserInfoResponse.fromRawJson(String str) =>
      UserInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic avatar;
  UserInfo? userInfo;

  Data({this.id, this.name, this.email, this.avatar, this.userInfo});

  Data copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    UserInfo? userInfo,
  }) => Data(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    userInfo: userInfo ?? this.userInfo,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    userInfo:
        json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "user_info": userInfo?.toJson(),
  };
}

class UserInfo {
  num? age;
  String? currentWeight;
  String? height;
  String? targetWeight;
  num? totalWorkoutsCompleted;
  num? totalCaloriesBurned;
  num? activeDays;

  UserInfo({
    this.age,
    this.currentWeight,
    this.height,
    this.targetWeight,
    this.totalWorkoutsCompleted,
    this.totalCaloriesBurned,
    this.activeDays,
  });

  UserInfo copyWith({
    num? age,
    String? currentWeight,
    String? height,
    String? targetWeight,
    num? totalWorkoutsCompleted,
    num? totalCaloriesBurned,
    num? activeDays,
  }) => UserInfo(
    age: age ?? this.age,
    currentWeight: currentWeight ?? this.currentWeight,
    height: height ?? this.height,
    targetWeight: targetWeight ?? this.targetWeight,
    totalWorkoutsCompleted:
        totalWorkoutsCompleted ?? this.totalWorkoutsCompleted,
    totalCaloriesBurned: totalCaloriesBurned ?? this.totalCaloriesBurned,
    activeDays: activeDays ?? this.activeDays,
  );

  factory UserInfo.fromRawJson(String str) =>
      UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    age: json["age"],
    currentWeight: json["current_weight"],
    height: json["height"],
    targetWeight: json["target_weight"],
    totalWorkoutsCompleted: json["total_workoutsCompleted"],
    totalCaloriesBurned: json["total_calories_burned"],
    activeDays: json["active_days"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "current_weight": currentWeight,
    "height": height,
    "target_weight": targetWeight,
    "total_workoutsCompleted": totalWorkoutsCompleted,
    "total_calories_burned": totalCaloriesBurned,
    "active_days": activeDays,
  };
}
