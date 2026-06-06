import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../../../core/utils/app_strings.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordLoading extends ForgotPasswordState {}
class ForgotPasswordSuccess extends ForgotPasswordState {
  final UserEntity user;
  const ForgotPasswordSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  const ForgotPasswordError(this.message);
  @override
  List<Object?> get props => [message];
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordCubit(this._forgotPasswordUseCase) : super(ForgotPasswordInitial());

  Future<void> sendCode({required String phone}) async {
    emit(ForgotPasswordLoading());
    try {
      final user = await _forgotPasswordUseCase.call("+966$phone");
      if (user.success ?? false) {
        emit(ForgotPasswordSuccess(user));
      } else {
        emit(const ForgotPasswordError(AppStrings.sendCodeError));
      }
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
