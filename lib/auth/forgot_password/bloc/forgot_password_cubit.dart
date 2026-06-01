import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';
import '../../../data/network/api_endpoints.dart';
import '../../../data/entity/user.dart';
import '../../../infrastructure/network/data_transfer_service.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> sendCode({required String phone}) async {
    emit(ForgotPasswordLoading());

    final endpoint = APIEndpoints.resetPassword(phone: "+966$phone");

    try {
      final user = await DefaultDataTransferService.apiManager.request(
        endpoint,
        (json) => User.fromJson(json),
      );

      if (user.success ?? false) {
        emit(ForgotPasswordSuccess(user));
      } else {
        String errorMessage = "فشل إرسال الرمز، يرجى التحقق من رقم الجوال";
        if (user.errors != null && user.errors!.isNotEmpty) {
          errorMessage = user.errors![0]['msg'] ?? errorMessage;
        }
        emit(ForgotPasswordError(errorMessage));
      }
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
