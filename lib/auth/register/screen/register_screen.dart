import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
            );
            Navigator.pop(context);
          } else if (state is RegisterError) {
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildBackButton(context),
                                        _buildRegisterAsBrokerButton(),
                                      ],
                                    ),
                                    const SizedBox(height: 60),
                                    _buildLogo(),
                                    const Spacer(),
                                    _buildLabel('الإسم'),
                                    const SizedBox(height: 8),
                                    _buildNameField(),
                                    const SizedBox(height: 16),
                                    _buildLabel('رقم الجوال'),
                                    const SizedBox(height: 8),
                                    _buildPhoneField(),
                                    const SizedBox(height: 16),
                                    _buildLabel('كلمة المرور'),
                                    const SizedBox(height: 8),
                                    _buildPasswordField(),
                                    const SizedBox(height: 12),
                                    _buildTermsCheckbox(),
                                    const SizedBox(height: 24),
                                    _buildRegisterButton(context, state),
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
                if (state is RegisterLoading)
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

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildRegisterAsBrokerButton() {
    return Container(
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
            'التسجيل كوسيط',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
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

  Widget _buildNameField() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: _nameController,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'إكتب الإسم',
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 13, fontFamily: 'Cairo'),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.arrow_drop_down, color: Colors.black87),
          const Text(
            '+966 SA',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(width: 8),
          const Text('🇸🇦', style: TextStyle(fontSize: 18)),
          const VerticalDivider(indent: 10, endIndent: 10, width: 25),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(9),
              ],
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'إكتب رقم الجوال',
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 13, fontFamily: 'Cairo'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'إكتب كلمة المرور',
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 13, fontFamily: 'Cairo'),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            value: _acceptTerms,
            activeColor: const Color(0xFF63B3AD),
            onChanged: (value) {
              setState(() {
                _acceptTerms = value ?? false;
              });
            },
          ),
        ),
        const Text(
          'للشروط والأحكام',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.underline,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context, RegisterState state) {
    return Center(
      child: ElevatedButton(
        onPressed: !_acceptTerms
            ? null
            : () {
                context.read<RegisterCubit>().register(
                      fullname: _nameController.text,
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
              'أنشئ حساب',
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
