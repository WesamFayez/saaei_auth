import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<UserEntity, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<UserEntity> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      newPassword: params.newPassword,
      phone: params.phone,
    );
  }
}

class ResetPasswordParams {
  final String newPassword;
  final String phone;

  ResetPasswordParams({
    required this.newPassword,
    required this.phone,
  });
}
