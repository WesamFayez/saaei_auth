import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase implements UseCase<UserEntity, String> {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<UserEntity> call(String phone) async {
    return await repository.forgotPassword(phone: phone);
  }
}
