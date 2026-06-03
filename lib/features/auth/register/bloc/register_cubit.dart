import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/core/utils/app_strings.dart';
import 'register_state.dart';
import '../../../../data/network/api_endpoints.dart';
import '../../../../data/entity/user.dart';
import '../../../../infrastructure/network/data_transfer_service.dart';
import '../../../../application/auth_manager.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register({
    required String fullname,
    required String phone,
    required String password,
    String type = "USER",
  }) async {
    emit(RegisterLoading());

    final endpoint = APIEndpoints.register(
      fullname: fullname,
      phone: "+966$phone",
      password: password,
      type: type,
    );

    try {
      final user = await DefaultDataTransferService.apiManager.request(
        endpoint,
        (json) => User.fromJson(json),
      );

      if (user.success ?? false) {
        AuthManager.shared.loginUser(user);
        emit(RegisterSuccess(user));
      } else {

        String errorMessage = AppStrings.sendSignUpError;


        if (user.errors != null && user.errors!.isNotEmpty) {
          errorMessage = user.errors![0]['msg'] ?? errorMessage;
        }
        emit(RegisterError(errorMessage));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
