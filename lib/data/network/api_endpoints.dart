import '../../infrastructure/network/endpoint.dart';
import '../entity/user.dart';

class APIEndpoints {

  static Endpoint<User> login({
    required String phone,
    required String password,
    required String fcmToken,
    required String udid,
  }) {
    return Endpoint<User>(
      path: "api/v1/signin",
      method: HTTPMethodType.post,
      isAuthenticate: false,
      bodyParameters: {
        "phone": phone,
        "password": password,
        "token": fcmToken,
        "udId": udid,
      },
    );
  }


  static Endpoint<User> register({
    required String fullname,
    required String phone,
    required String password,
    required String type,
  }) {
    return Endpoint<User>(
      path: "api/v1/signup",
      method: HTTPMethodType.post,
      isAuthenticate: false,
      bodyParameters: {
        "country": "1",
        "fullname": fullname,
        "phone": phone,
        "type": type,
        "password": password,
        "token": "",
      },
    );
  }

  static Endpoint<User> resetPassword({required String phone}) {
    return Endpoint<User>(
      path: "api/v1/sendCode-phone",
      isAuthenticate: false,
      method: HTTPMethodType.post,
      bodyParameters: {"phone": phone},
    );
  }

  static Endpoint<User> verifyAccount({required String code, required String phone}) {
    return Endpoint<User>(
      path: "api/v1/verifyAccount",
      isAuthenticate: false,
      method: HTTPMethodType.put,
      bodyParameters: {"verifycode": code, "phone": phone},
    );
  }

  static Endpoint<User> setNewPasswordAfterRest({required String newPassword, required String phone}) {
    return Endpoint<User>(
      path: "api/v1/reset-password-phone",
      isAuthenticate: false,
      method: HTTPMethodType.post,
      bodyParameters: {"newPassword": newPassword, "phone": phone},
    );
  }
}
