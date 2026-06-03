import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saaei_auth/core/widgets/custom_text_field.dart';
import 'package:saaei_auth/core/widgets/custom_phone_field.dart';
import 'package:saaei_auth/core/widgets/custom_button.dart';
import 'package:saaei_auth/core/widgets/auth_shared_widgets.dart';
import 'package:saaei_auth/core/routing/app_router.dart';
import 'package:saaei_auth/core/utils/validators.dart';
import 'package:saaei_auth/core/utils/context_extension.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';
import 'package:saaei_auth/core/utils/app_strings.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        const SnackBar(content: Text(AppStrings.loginSuccess)),
      );
      context.go(AppRouter.main);
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
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: AuthBrokerBadge(text: AppStrings.brokerLogin),
                      ),
                      SizedBox(height: 80.h),
                      const AuthAppLogo(),
                      SizedBox(height: 100.h),
                      const _SignUpLink(),
                      const Spacer(),
                      const AuthLabel(AppStrings.phoneFieldLabel),
                      SizedBox(height: 8.h),
                      CustomPhoneField(
                        controller: _phoneController,
                        validator: Validators.validatePhone,
                      ),
                      SizedBox(height: 20.h),
                      const AuthLabel(AppStrings.passwordFieldLabel),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: AppStrings.writePassword,
                        isPassword: true,
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(height: 12.h),
                      const _ForgotPassword(),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: AppStrings.login,
                        icon: Icons.login_outlined,
                        onPressed: () => _onLoginPressed(context),
                      ),
                      SizedBox(height: 40.h),
                      const AuthFooter(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
            phone: _phoneController.text,
            password: _passwordController.text,
          );
    }
  }
}

class _SignUpLink extends StatelessWidget {
  const _SignUpLink();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.login_outlined, color: AppColors.white, size: 20.sp),
        SizedBox(width: 8.w),
        InkWell(
          onTap: () => context.push(AppRouter.register),
          child: Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.white))),
            child: Text(
              AppStrings.createAccount,
              style: AppTextStyles.cairoMedium.copyWith(
                color: AppColors.white,
                fontSize: 18.sp,
              ),
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
        onTap: () => context.push(AppRouter.forgotPassword),
        child: Text(
          AppStrings.forgotPassword,
          style: AppTextStyles.cairoRegular.copyWith(
            color: AppColors.white,
            fontSize: 13.sp,
          )
        ),
      ),
    );
  }
}
