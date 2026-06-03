import 'package:flutter_bloc/flutter_bloc.dart';
import 'verification_state.dart';
import '../../../../data/network/api_endpoints.dart';
import '../../../../data/entity/user.dart';
import '../../../../infrastructure/network/data_transfer_service.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  Future<void> verifyCode({required String code, required String phone}) async {
    emit(VerificationLoading());

    final endpoint = APIEndpoints.verifyAccount(code: code, phone: phone);

    try {
      final user = await DefaultDataTransferService.apiManager.request(
        endpoint,
        (json) => User.fromJson(json),
      );

      if (user.success ?? false) {
        emit(VerificationSuccess(user));
      } else {
        String errorMessage = "الرمز غير صحيح، يرجى المحاولة مرة أخرى";
        if (user.errors != null && user.errors!.isNotEmpty) {
          errorMessage = user.errors![0]['msg'] ?? errorMessage;
        }
        emit(VerificationError(errorMessage));
      }
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }
}
