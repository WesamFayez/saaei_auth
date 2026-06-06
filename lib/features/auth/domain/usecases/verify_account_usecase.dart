import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyAccountUseCase implements UseCase<UserEntity, VerifyAccountParams> {
  final AuthRepository repository;

  VerifyAccountUseCase(this.repository);

  @override
  Future<UserEntity> call(VerifyAccountParams params) async {
    return await repository.verifyAccount(
      code: params.code,
      phone: params.phone,
    );
  }
}

class VerifyAccountParams {
  final String code;
  final String phone;

  VerifyAccountParams({
    required this.code,
    required this.phone,
  });
}
