import '../../../../core/network/data_transfer_service.dart';
import '../../../../core/network/endpoint.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String phone,
    required String password,
    required String fcmToken,
    required String udid,
  });

  Future<UserModel> register({
    required String fullname,
    required String phone,
    required String password,
    required String type,
  });

  Future<UserModel> forgotPassword({required String phone});

  Future<UserModel> verifyAccount({required String code, required String phone});

  Future<UserModel> resetPassword({required String newPassword, required String phone});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DataTransferService _dataTransferService;

  AuthRemoteDataSourceImpl(this._dataTransferService);

  @override
  Future<UserModel> login({
    required String phone,
    required String password,
    required String fcmToken,
    required String udid,
  }) {
    return _dataTransferService.request(
      Endpoint<UserModel>(
        path: "api/v1/signin",
        method: HTTPMethodType.post,
        isAuthenticate: false,
        bodyParameters: {
          "phone": phone,
          "password": password,
          "token": fcmToken,
          "udId": udid,
        },
      ),
      (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<UserModel> register({
    required String fullname,
    required String phone,
    required String password,
    required String type,
  }) {
    return _dataTransferService.request(
      Endpoint<UserModel>(
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
      ),
      (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<UserModel> forgotPassword({required String phone}) {
    return _dataTransferService.request(
      Endpoint<UserModel>(
        path: "api/v1/sendCode-phone",
        isAuthenticate: false,
        method: HTTPMethodType.post,
        bodyParameters: {"phone": phone},
      ),
      (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<UserModel> verifyAccount({required String code, required String phone}) {
    return _dataTransferService.request(
      Endpoint<UserModel>(
        path: "api/v1/verifyAccount",
        isAuthenticate: false,
        method: HTTPMethodType.put,
        bodyParameters: {"verifycode": code, "phone": phone},
      ),
      (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<UserModel> resetPassword({required String newPassword, required String phone}) {
    return _dataTransferService.request(
      Endpoint<UserModel>(
        path: "api/v1/reset-password-phone",
        isAuthenticate: false,
        method: HTTPMethodType.post,
        bodyParameters: {"newPassword": newPassword, "phone": phone},
      ),
      (json) => UserModel.fromJson(json),
    );
  }
}
