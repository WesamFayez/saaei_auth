class User {
  final bool? success;
  final UserInfo? userInfo;
  final List<dynamic>? errors;
  final int? adsCount;
  final int? contactRequestCount;
  final int? adsRequestCount;
  final int? viewsCount;
  final String? token;

  User({
    this.success,
    this.userInfo,
    this.errors,
    this.adsCount,
    this.contactRequestCount,
    this.adsRequestCount,
    this.viewsCount,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['success'],
      userInfo: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
      errors: json['errors'],
      adsCount: json['adsCount'],
      contactRequestCount: json['contactRequestCount'],
      adsRequestCount: json['adsRequestCount'],
      viewsCount: json['viewsCount'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'user': userInfo?.toJson(),
      'errors': errors,
      'adsCount': adsCount,
      'contactRequestCount': contactRequestCount,
      'adsRequestCount': adsRequestCount,
      'viewsCount': viewsCount,
      'token': token,
    };
  }
}

class UserInfo {
  final int? id;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? type;
  final String? img;
  final String? idType;
  final String? accountType;
  final bool? enableNotif;
  final bool? online;
  final bool? isVerified;
  final bool? completProfile;

  UserInfo({
    this.id,
    this.fullname,
    this.email,
    this.phone,
    this.type,
    this.img,
    this.idType,
    this.accountType,
    this.enableNotif,
    this.online,
    this.isVerified,
    this.completProfile,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      img: json['img'],
      idType: json['idType']?.toString(),
      accountType: json['accountType'],
      enableNotif: json['enableNotif'],
      online: json['online'],
      isVerified: json['isVerified'],
      completProfile: json['completProfile'],
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
      'idType': idType,
      'accountType': accountType,
      'enableNotif': enableNotif,
      'online': online,
      'isVerified': isVerified,
      'completProfile': completProfile,
    };
  }
}
