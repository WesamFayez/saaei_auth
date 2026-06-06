import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> login({
    required String phone,
    required String password,
    required String fcmToken,
    required String udid,
  }) async {
    return await _remoteDataSource.login(
      phone: phone,
      password: password,
      fcmToken: fcmToken,
      udid: udid,
    );
  }

  @override
  Future<UserEntity> register({
    required String fullname,
    required String phone,
    required String password,
    required String type,
  }) async {
    return await _remoteDataSource.register(
      fullname: fullname,
      phone: phone,
      password: password,
      type: type,
    );
  }

  @override
  Future<UserEntity> forgotPassword({required String phone}) async {
    return await _remoteDataSource.forgotPassword(phone: phone);
  }

  @override
  Future<UserEntity> verifyAccount({required String code, required String phone}) async {
    return await _remoteDataSource.verifyAccount(code: code, phone: phone);
  }

  @override
  Future<UserEntity> resetPassword({required String newPassword, required String phone}) async {
    return await _remoteDataSource.resetPassword(newPassword: newPassword, phone: phone);
  }
}
