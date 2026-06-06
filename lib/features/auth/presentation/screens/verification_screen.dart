import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_otp_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/auth_shared_widgets.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/di/di.dart';
import '../bloc/verification_cubit.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;
  const VerificationScreen({super.key, required this.phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(sl()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<VerificationCubit, VerificationState>(
          listener: _handleState,
          builder: (context, state) {
            return Stack(
              children: [
                const AuthBackground(),
                SafeArea(
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
                                  const Center(child: AuthLabel(AppStrings.enterVerificationCode)),
                                  SizedBox(height: 30.h),
                                  CustomOtpField(
                                    controller: _codeController,
                                    validator: (value) {
                                      if (value == null || value.length < 4) {
                                        return AppStrings.otpIncomplete;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 40.h),
                                  CustomButton(
                                    text: AppStrings.verify,
                                    icon: Icons.login_outlined,
                                    useOpacity: true,
                                    onPressed: () => _onVerifyPressed(context),
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
                ),
                if (state is VerificationLoading) const AuthLoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, VerificationState state) {
    if (state is VerificationSuccess) {
      context.push(AppRouter.resetPassword, extra: widget.phone);
    } else if (state is VerificationError) {
      context.showErrorDialog(state.message);
    }
  }

  void _onVerifyPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<VerificationCubit>().verifyCode(
            code: _codeController.text,
            phone: widget.phone,
          );
    }
  }
}
