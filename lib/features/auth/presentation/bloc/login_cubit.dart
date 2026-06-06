import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../../core/utils/auth_manager.dart';
import '../../../../core/utils/app_strings.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final UserEntity user;
  const LoginSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
  @override
  List<Object?> get props => [message];
}

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> login({required String phone, required String password}) async {
    emit(LoginLoading());
    try {
      final user = await _loginUseCase.call(
        LoginParams(
          phone: "+966$phone",
          password: password,
          fcmToken: "",
          udid: "udid",
        ),
      );

      if (user.success ?? false) {
        AuthManager.shared.loginUser(user);
        emit(LoginSuccess(user));
      } else {
        emit(const LoginError(AppStrings.sendLoginError));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
