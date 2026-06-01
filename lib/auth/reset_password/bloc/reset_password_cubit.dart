import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_state.dart';
import '../../../data/network/api_endpoints.dart';
import '../../../data/entity/user.dart';
import '../../../infrastructure/network/data_transfer_service.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword({required String newPassword, required String phone}) async {
    emit(ResetPasswordLoading());

    final endpoint = APIEndpoints.setNewPasswordAfterRest(newPassword: newPassword, phone: phone);

    try {
      final user = await DefaultDataTransferService.apiManager.request(
        endpoint,
        (json) => User.fromJson(json),
      );

      if (user.success ?? false) {
        emit(ResetPasswordSuccess(user));
      } else {
        String errorMessage = "فشل تغيير كلمة المرور، يرجى المحاولة مرة أخرى";
        if (user.errors != null && user.errors!.isNotEmpty) {
          errorMessage = user.errors![0]['msg'] ?? errorMessage;
        }
        emit(ResetPasswordError(errorMessage));
      }
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }
}
