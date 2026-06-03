import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/core/utils/app_strings.dart';
import 'login_state.dart';
import '../../../../data/network/api_endpoints.dart';
import '../../../../data/entity/user.dart';
import '../../../../infrastructure/network/data_transfer_service.dart';
import '../../../../application/auth_manager.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String phone, required String password}) async {
    emit(LoginLoading());

    final endpoint = APIEndpoints.login(
      phone: "+966$phone",
      password: password,
      fcmToken: "",
      udid: "udid",
    );

    try {
      final user = await DefaultDataTransferService.apiManager.request(
        endpoint,
        (json) => User.fromJson(json),
      );

      if (user.success ?? false) {
        AuthManager.shared.loginUser(user);
        emit(LoginSuccess(user));
      } else {

        String errorMessage = AppStrings.sendLoginError;


        if (user.errors != null && user.errors!.isNotEmpty) {
          errorMessage = user.errors![0]['msg'] ?? errorMessage;
        }
        emit(LoginError(errorMessage));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
