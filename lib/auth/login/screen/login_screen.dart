import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saaei_auth/application/navigation_extension.dart';
import '../../register/screen/register_screen.dart';
import '../../widgets/auth_phone_field.dart';
import '../../widgets/auth_password_field.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
            );
          } else if (state is LoginError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('خطأ', style: TextStyle(fontFamily: 'Cairo')),
                content: Text(state.message, style: const TextStyle(fontFamily: 'Cairo')),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('حسناً', style: TextStyle(fontFamily: 'Cairo')),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/authBG.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 10),
                                    _buildLoginAsBrokerButton(),
                                    const SizedBox(height: 80),
                                    _buildLogo(),
                                    const SizedBox(height: 100),
                                    _buildSignUpButton(context),
                                    const Spacer(),
                                    _buildLabel('رقم الجوال'),
                                    const SizedBox(height: 8),
                                    AuthPhoneField(controller: _phoneController),
                                    const SizedBox(height: 20),
                                    _buildLabel('كلمة المرور'),
                                    const SizedBox(height: 8),
                                    AuthPasswordField(controller: _passwordController),
                                    const SizedBox(height: 12),
                                    _buildForgotPasswordText(),
                                    const SizedBox(height: 24),
                                    _buildLoginButton(context),
                                    const SizedBox(height: 40),
                                    _buildBottomLinks(),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (state is LoginLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF63B3AD),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginAsBrokerButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.login_outlined, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'الدخول كوسيط',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        'assets/logo.png',
        width: 190,
        height: 70,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.login_outlined, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            pushTo(context, const RegisterScreen());
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
            ),
            child: const Text(
              'انشاء حساب',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Cairo',
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {},
        child: const Text(
          'نسيت كلمة المرور ؟',
          style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Cairo'),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<LoginCubit>().login(
                phone: _phoneController.text,
                password: _passwordController.text,
              );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF63B3AD),
          minimumSize: const Size(160, 42),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login_outlined, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Text(
              'تسجيل دخول',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBottomItem(Icons.info_outline, 'عن ساعي'),
        const SizedBox(width: 20),
        Container(height: 30, width: 1, color: Colors.white24),
        const SizedBox(width: 20),
        _buildBottomItem(Icons.headset_mic_outlined, 'اتصل بنا'),
      ],
    );
  }

  Widget _buildBottomItem(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontFamily: 'Cairo'),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: Colors.white, size: 22),
        ],
      ),
    );
  }
}
