import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_phone_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/auth_shared_widgets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/di/di.dart';
import '../bloc/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(sl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: _handleState,
          builder: (context, state) {
            return Stack(
              children: [
                const AuthBackground(),
                _buildBody(context),
                if (state is RegisterLoading) const AuthLoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, RegisterState state) {
    if (state is RegisterSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.registerSuccess)),
      );
      Navigator.pop(context);
    } else if (state is RegisterError) {
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AuthBackButton(),
                          AuthBrokerBadge(text: AppStrings.brokerRegister),
                        ],
                      ),
                      SizedBox(height: 60.h),
                      const AuthAppLogo(),
                      const Spacer(),
                      const AuthLabel(AppStrings.nameFieldLabel),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _nameController,
                        hintText: AppStrings.writeName,
                        validator: (val) => Validators.validateRequired(val, AppStrings.nameFieldLabel),
                      ),
                      SizedBox(height: 16.h),
                      const AuthLabel(AppStrings.phoneFieldLabel),
                      SizedBox(height: 8.h),
                      CustomPhoneField(
                        controller: _phoneController,
                        validator: Validators.validatePhone,
                      ),
                      SizedBox(height: 16.h),
                      const AuthLabel(AppStrings.passwordFieldLabel),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: AppStrings.writePassword,
                        isPassword: true,
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(height: 12.h),
                      _TermsCheckbox(
                        value: _acceptTerms,
                        onChanged: (val) => setState(() => _acceptTerms = val),
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: AppStrings.register,
                        icon: Icons.login_outlined,
                        onPressed: () => _onRegisterPressed(context),
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

  void _onRegisterPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        context.showErrorDialog(AppStrings.acceptTermsRequired);
        return;
      }

      context.read<RegisterCubit>().register(
            fullname: _nameController.text,
            phone: _phoneController.text,
            password: _passwordController.text,
          );
    }
  }
}

class _TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _TermsCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            value: value,
            activeColor: AppColors.secondary,
            onChanged: (val) => onChanged(val ?? false),
          ),
        ),
        Text(
          AppStrings.termsAndConditions,
          style: AppTextStyles.cairoRegular.copyWith(
            color: Colors.white,
            fontSize: 14.sp,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
