import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<UserEntity> call(RegisterParams params) async {
    return await repository.register(
      fullname: params.fullname,
      phone: params.phone,
      password: params.password,
      type: params.type,
    );
  }
}

class RegisterParams {
  final String fullname;
  final String phone;
  final String password;
  final String type;

  RegisterParams({
    required this.fullname,
    required this.phone,
    required this.password,
    required this.type,
  });
}
