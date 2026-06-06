import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../../../core/utils/app_strings.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();
  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordLoading extends ResetPasswordState {}
class ResetPasswordSuccess extends ResetPasswordState {
  final UserEntity user;
  const ResetPasswordSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class ResetPasswordError extends ResetPasswordState {
  final String message;
  const ResetPasswordError(this.message);
  @override
  List<Object?> get props => [message];
}

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordCubit(this._resetPasswordUseCase) : super(ResetPasswordInitial());

  Future<void> resetPassword({required String newPassword, required String phone}) async {
    emit(ResetPasswordLoading());
    try {
      final user = await _resetPasswordUseCase.call(
        ResetPasswordParams(newPassword: newPassword, phone: phone),
      );
      if (user.success ?? false) {
        emit(ResetPasswordSuccess(user));
      } else {
        emit(const ResetPasswordError(AppStrings.sendResetPasswordError));
      }
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }
}
