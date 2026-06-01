import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/extensions/auth_dialog.dart';
import '../../widgets/auth_phone_field.dart';
import '../../widgets/auth_password_field.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_ui_components.dart';
import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
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
      create: (context) => RegisterCubit(),
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
        const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthBackButton(),
                        AuthBrokerBadge(text: 'التسجيل كوسيط'),
                      ],
                    ),
                    const SizedBox(height: 60),
                    const AuthAppLogo(),
                    const Spacer(),
                    const AuthLabel('الإسم'),
                    const SizedBox(height: 8),
                    _NameField(controller: _nameController),
                    const SizedBox(height: 16),
                    const AuthLabel('رقم الجوال'),
                    const SizedBox(height: 8),
                    AuthPhoneField(controller: _phoneController),
                    const SizedBox(height: 16),
                    const AuthLabel('كلمة المرور'),
                    const SizedBox(height: 8),
                    AuthPasswordField(controller: _passwordController),
                    const SizedBox(height: 12),
                    _TermsCheckbox(
                      value: _acceptTerms,
                      onChanged: (val) => setState(() => _acceptTerms = val),
                    ),
                    const SizedBox(height: 24),
                    AuthPrimaryButton(
                      text: 'أنشئ حساب',
                      icon: Icons.login_outlined,
                      onPressed: () => _onRegisterPressed(context),
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

  void _onRegisterPressed(BuildContext context) {
    if (_nameController.text.isEmpty) {
      context.showErrorDialog('يرجى كتابة الإسم أولاً');
      return;
    }
    if (_phoneController.text.isEmpty) {
      context.showErrorDialog('يرجى كتابة رقم الجوال أولاً');
      return;
    }
    if (_passwordController.text.isEmpty) {
      context.showErrorDialog('يرجى كتابة كلمة المرور أولاً');
      return;
    }
    if (!_acceptTerms) {
      context.showErrorDialog('يجب الموافقة على الشروط والأحكام للمتابعة');
      return;
    }

    context.read<RegisterCubit>().register(
          fullname: _nameController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        );
  }
}



class _NameField extends StatelessWidget {
  final TextEditingController controller;
  const _NameField({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: TextField(
          controller: controller,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'إكتب الإسم',
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Cairo'),
          ),
        ),
      ),
    );
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
            activeColor: const Color(0xFF63B3AD),
            onChanged: (val) => onChanged(val ?? false),
          ),
        ),
        const Text(
          'للشروط والأحكام',
          style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.underline, fontFamily: 'Cairo'),
        ),
      ],
    );
  }
}
