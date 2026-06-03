// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get phone => 'رقم الجوال';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور ؟';

  @override
  String get name => 'الإسم';

  @override
  String get acceptTerms => 'للشروط والأحكام';

  @override
  String get sendCode => 'ارسل الرمز';

  @override
  String get verifyCode => 'تحقق';

  @override
  String get savePassword => 'حفظ كلمة المرور الجديدة';
}
