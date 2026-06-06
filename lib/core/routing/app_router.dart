import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/verification_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/home/presentation/screens/main_screen.dart';

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
