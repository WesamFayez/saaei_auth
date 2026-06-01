import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/application/navigation_extension.dart';
import 'package:saaei_auth/extensions/auth_dialog.dart';
import 'package:saaei_auth/main/screens/main_screen.dart';
import '../../register/screen/register_screen.dart';
import '../../forgot_password/screen/forgot_password_screen.dart';
import '../../widgets/auth_phone_field.dart';
import '../../widgets/auth_password_field.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_ui_components.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: _handleState,
          builder: (context, state) {
            return Stack(
              children: [
                const AuthBackground(),
                _buildBody(context),
                if (state is LoginLoading) const AuthLoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
      );
      pushAndRemoveAll(context, const MainScreen());
    } else if (state is LoginError) {
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
                      alignment: Alignment.centerLeft,
                      child: AuthBrokerBadge(text: 'الدخول كوسيط'),
                    ),
                    const SizedBox(height: 80),
                    const AuthAppLogo(),
                    const SizedBox(height: 100),
                    const _SignUpLink(),
                    const Spacer(),
                    const AuthLabel('رقم الجوال'),
                    const SizedBox(height: 8),
                    AuthPhoneField(controller: _phoneController),
                    const SizedBox(height: 20),
                    const AuthLabel('كلمة المرور'),
                    const SizedBox(height: 8),
                    AuthPasswordField(controller: _passwordController),
                    const SizedBox(height: 12),
                    const _ForgotPassword(),
                    const SizedBox(height: 24),
                    AuthPrimaryButton(
                      text: 'تسجيل دخول',
                      icon: Icons.login_outlined,
                      onPressed: () => _onLoginPressed(context),
                    ),
                    const SizedBox(height: 40),
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

  void _onLoginPressed(BuildContext context) {
    if (_phoneController.text.isEmpty) {
      context.showErrorDialog('يرجى كتابة رقم الجوال أولاً');
      return;
    }
    if (_passwordController.text.isEmpty) {
      context.showErrorDialog('يرجى كتابة كلمة المرور أولاً');
      return;
    }

    context.read<LoginCubit>().login(
          phone: _phoneController.text,
          password: _passwordController.text,
        );
  }
}

class _SignUpLink extends StatelessWidget {
  const _SignUpLink();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.login_outlined, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => pushTo(context, const RegisterScreen()),
          child: Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
            child: const Text(
              'انشاء حساب',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Cairo'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () => pushTo(context, const ForgotPasswordScreen()),
        child: const Text('نسيت كلمة المرور ؟', style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Cairo')),
      ),
    );
  }
}
