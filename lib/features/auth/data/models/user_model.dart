import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.success,
    super.userInfo,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'],
      userInfo: json['user'] != null ? UserInfoModel.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'user': (userInfo as UserInfoModel?)?.toJson(),
      'token': token,
    };
  }
}

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    super.id,
    super.fullname,
    super.email,
    super.phone,
    super.type,
    super.img,
    super.isVerified,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      img: json['img'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'type': type,
      'img': img,
      'isVerified': isVerified,
    };
  }
}
