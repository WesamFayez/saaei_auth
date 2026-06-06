import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String phone,
    required String password,
    required String fcmToken,
    required String udid,
  });

  Future<UserEntity> register({
    required String fullname,
    required String phone,
    required String password,
    required String type,
  });

  Future<UserEntity> forgotPassword({required String phone});

  Future<UserEntity> verifyAccount({required String code, required String phone});

  Future<UserEntity> resetPassword({required String newPassword, required String phone});
}
