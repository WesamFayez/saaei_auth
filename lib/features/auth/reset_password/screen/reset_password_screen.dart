import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saaei_auth/core/widgets/custom_text_field.dart';
import 'package:saaei_auth/core/widgets/custom_button.dart';
import 'package:saaei_auth/core/widgets/auth_shared_widgets.dart';
import 'package:saaei_auth/core/routing/app_router.dart';
import 'package:saaei_auth/core/utils/validators.dart';
import 'package:saaei_auth/core/utils/context_extension.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';
import 'package:saaei_auth/core/utils/app_strings.dart';
import '../bloc/reset_password_cubit.dart';
import '../bloc/reset_password_state.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String phone;
  const ResetPasswordScreen({super.key, required this.phone});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: _handleState,
          builder: (context, state) {
            return Stack(
              children: [
                const AuthBackground(),
                _buildBody(context),
                if (state is ResetPasswordLoading) const AuthLoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, ResetPasswordState state) {
    if (state is ResetPasswordSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.changePasswordSuccesfully)),
      );
      context.go(AppRouter.login);
    } else if (state is ResetPasswordError) {
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
                        alignment: Alignment.centerRight,
                        child: AuthBackButton(),
                      ),
                      SizedBox(height: 60.h),
                      const AuthAppLogo(),
                      const Spacer(),
                      const AuthLabel(AppStrings.enterNewPassword),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: AppStrings.writeNewPassword,
                        isPassword: true,
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(height: 20.h),
                      const AuthLabel(AppStrings.reEnterNewPassword),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: AppStrings.writeNewPassword,
                        isPassword: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return AppStrings.passwordsNotMatch;
                          }
                          return Validators.validatePassword(value);
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomButton(
                        text: AppStrings.saveNewPassword,
                        icon: Icons.save_outlined,
                        useOpacity: true,
                        onPressed: () => _onSavePressed(context),
                      ),
                      const Spacer(),
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

  void _onSavePressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().resetPassword(
            newPassword: _passwordController.text,
            phone: widget.phone,
          );
    }
  }
}
