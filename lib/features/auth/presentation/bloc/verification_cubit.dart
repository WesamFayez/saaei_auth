import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/verify_account_usecase.dart';
import '../../../../core/utils/app_strings.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();
  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}
class VerificationLoading extends VerificationState {}
class VerificationSuccess extends VerificationState {
  final UserEntity user;
  const VerificationSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class VerificationError extends VerificationState {
  final String message;
  const VerificationError(this.message);
  @override
  List<Object?> get props => [message];
}

class VerificationCubit extends Cubit<VerificationState> {
  final VerifyAccountUseCase _verifyAccountUseCase;

  VerificationCubit(this._verifyAccountUseCase) : super(VerificationInitial());

  Future<void> verifyCode({required String code, required String phone}) async {
    emit(VerificationLoading());
    try {
      final user = await _verifyAccountUseCase.call(
        VerifyAccountParams(code: code, phone: phone),
      );
      if (user.success ?? false) {
        emit(VerificationSuccess(user));
      } else {
        emit(const VerificationError(AppStrings.otpIncomplete));
      }
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }
}
