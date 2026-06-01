import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/extensions/auth_dialog.dart';
import '../../../application/navigation_extension.dart';
import '../../widgets/auth_password_field.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_ui_components.dart';
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
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
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
                    const AuthLabel('ادخل كلمة المرور الجديدة'),
                    const SizedBox(height: 8),
                    AuthPasswordField(
                      controller: _passwordController,
                      hintText: 'إكتب كلمة المرور الجديدة',
                    ),
                    const SizedBox(height: 20),
                    const AuthLabel('أعد كتابة كلمة المرور الجديدة'),
                    const SizedBox(height: 8),
                    AuthPasswordField(
                      controller: _confirmPasswordController,
                      hintText: 'إكتب كلمة المرور الجديدة',
                    ),
                    const SizedBox(height: 40),
                    AuthPrimaryButton(
                      text: 'حفظ كلمة المرور الجديدة',
                      icon: Icons.save_outlined,
                      useOpacity: true,
                      onPressed: () => _onSavePressed(context),
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

  void _onSavePressed(BuildContext context) {
    if (_passwordController.text.isEmpty) {
      context.showErrorDialog('يرجى إدخال كلمة المرور الجديدة');
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      context.showErrorDialog('كلمتا المرور غير متطابقتين');
      return;
    }

    context.read<ResetPasswordCubit>().resetPassword(
          newPassword: _passwordController.text,
          phone: widget.phone,
        );
  }
}
