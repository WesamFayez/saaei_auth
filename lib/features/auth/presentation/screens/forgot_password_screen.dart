import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_phone_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/auth_shared_widgets.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/di/di.dart';
import '../bloc/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(sl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              context.push(AppRouter.verification, extra: "+966${_phoneController.text}");
            } else if (state is ForgotPasswordError) {
              context.showErrorDialog(state.message);
            }
          },
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
                      const AuthLabel(AppStrings.phoneForVerification),
                      SizedBox(height: 12.h),
                      CustomPhoneField(
                        controller: _phoneController,
                        validator: Validators.validatePhone,
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        text: AppStrings.sendCode,
                        icon: Icons.login_outlined,
                        useOpacity: true,
                        onPressed: () => _onSendCodePressed(context),
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

  void _onSendCodePressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().sendCode(
            phone: _phoneController.text,
          );
    }
  }
}
