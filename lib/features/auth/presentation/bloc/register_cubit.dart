import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../../../core/utils/auth_manager.dart';
import '../../../../core/utils/app_strings.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  final UserEntity user;
  const RegisterSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class RegisterError extends RegisterState {
  final String message;
  const RegisterError(this.message);
  @override
  List<Object?> get props => [message];
}

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String fullname,
    required String phone,
    required String password,
    String type = "USER",
  }) async {
    emit(RegisterLoading());
    try {
      final user = await _registerUseCase.call(
        RegisterParams(
          fullname: fullname,
          phone: "+966$phone",
          password: password,
          type: type,
        ),
      );

      if (user.success ?? false) {
        AuthManager.shared.loginUser(user);
        emit(RegisterSuccess(user));
      } else {
        emit(const RegisterError(AppStrings.sendSignUpError));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
