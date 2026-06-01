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
}
