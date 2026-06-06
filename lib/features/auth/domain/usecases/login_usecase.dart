import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) async {
    return await repository.login(
      phone: params.phone,
      password: params.password,
      fcmToken: params.fcmToken,
      udid: params.udid,
    );
  }
}

class LoginParams {
  final String phone;
  final String password;
  final String fcmToken;
  final String udid;

  LoginParams({
    required this.phone,
    required this.password,
    required this.fcmToken,
    required this.udid,
  });
}
