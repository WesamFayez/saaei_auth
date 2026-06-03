import 'package:go_router/go_router.dart';
import '../../features/auth/login/screen/login_screen.dart';
import '../../features/auth/register/screen/register_screen.dart';
import '../../features/auth/forgot_password/screen/forgot_password_screen.dart';
import '../../features/auth/verification/screen/verification_screen.dart';
import '../../features/auth/reset_password/screen/reset_password_screen.dart';
import '../../features/home/screens/main_screen.dart';

class AppRouter {
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const verification = '/verification';
  static const resetPassword = '/reset-password';
  static const main = '/main';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: verification,
        builder: (context, state) {
          final phone = state.extra as String;
          return VerificationScreen(phone: phone);
        },
      ),
      GoRoute(
        path: resetPassword,
        builder: (context, state) {
          final phone = state.extra as String;
          return ResetPasswordScreen(phone: phone);
        },
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}
