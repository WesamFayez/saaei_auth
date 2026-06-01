import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/extensions/auth_dialog.dart';
import '../../../application/navigation_extension.dart';
import '../../reset_password/screen/reset_password_screen.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_ui_components.dart';
import '../bloc/verification_cubit.dart';
import '../bloc/verification_state.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;
  const VerificationScreen({super.key, required this.phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<VerificationCubit, VerificationState>(
          listener: _handleState,
          builder: (context, state) {
            return Stack(
              children: [
                const AuthBackground(),
                _buildBody(context),
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
      pushTo(context, ResetPasswordScreen(phone: widget.phone));
    } else if (state is VerificationError) {
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
                    const _TopBackAction(),
                    const SizedBox(height: 60),
                    const AuthAppLogo(),
                    const Spacer(),
                    const Center(child: AuthLabel('ادخل رمز التحقق')),
                    const SizedBox(height: 30),
                    _OtpField(controller: _codeController),
                    const SizedBox(height: 40),
                    _VerifyButton(
                      onPressed: () => _onVerifyPressed(context),
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

  void _onVerifyPressed(BuildContext context) {
    if (_codeController.text.length < 4) {
      context.showErrorDialog('يرجى إدخال رمز التحقق كاملاً');
      return;
    }

    context.read<VerificationCubit>().verifyCode(
          code: _codeController.text,
          phone: widget.phone,
        );
  }
}

class _TopBackAction extends StatelessWidget {
  const _TopBackAction();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Image.asset(
            'assets/back-icon-white.png',
            width: 18,
            height: 18,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  final TextEditingController controller;
  const _OtpField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 4,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 20,
          ),
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _VerifyButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _VerifyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF63B3AD).withOpacity(0.7),
          minimumSize: const Size(160, 42),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.login_outlined, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Text('ارسل الرمز', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
