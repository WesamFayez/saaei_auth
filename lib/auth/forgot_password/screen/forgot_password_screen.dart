import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/extensions/auth_dialog.dart';
import '../../../application/navigation_extension.dart';
import '../../verification/screen/verification_screen.dart';
import '../../widgets/auth_phone_field.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_ui_components.dart';
import '../bloc/forgot_password_cubit.dart';
import '../bloc/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: _handleState,
          builder: (context, state) {
            return Stack(
              children: [
                const AuthBackground(),
                _buildBody(context),
                if (state is ForgotPasswordLoading) const AuthLoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, ForgotPasswordState state) {
    if (state is ForgotPasswordSuccess) {
      pushTo(context, VerificationScreen(phone: "+966${_phoneController.text}"));
    } else if (state is ForgotPasswordError) {
      context.showErrorDialog(state.message);
    }
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: AuthBackButton(),
                    ),
                    const SizedBox(height: 60),
                    const AuthAppLogo(),
                    const Spacer(),
                    const AuthLabel('رقم الجوال لاستقبال رمز التحقق'),
                    const SizedBox(height: 12),
                    AuthPhoneField(controller: _phoneController),
                    const SizedBox(height: 30),
                    AuthPrimaryButton(
                      text: 'ارسل الرمز',
                      icon: Icons.login_outlined,
                      useOpacity: true,
                      onPressed: () => _onSendCodePressed(context),
                    ),
                    const Spacer(),
                    const AuthFooter(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSendCodePressed(BuildContext context) {
    if (_phoneController.text.isEmpty) {
      context.showErrorDialog('يرجى كتابة رقم الجوال أولاً');
      return;
    }

    context.read<ForgotPasswordCubit>().sendCode(
      phone: _phoneController.text,
    );
  }
}
