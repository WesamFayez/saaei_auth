class UserEntity {
  final bool? success;
  final UserInfoEntity? userInfo;
  final String? token;

  UserEntity({
    this.success,
    this.userInfo,
    this.token,
  });
}

class UserInfoEntity {
  final int? id;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? type;
  final String? img;
  final bool? isVerified;

  UserInfoEntity({
    this.id,
    this.fullname,
    this.email,
    this.phone,
    this.type,
    this.img,
    this.isVerified,
  });
}
