// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get phone => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get name => 'Name';

  @override
  String get acceptTerms => 'Terms and Conditions';

  @override
  String get sendCode => 'Send Code';

  @override
  String get verifyCode => 'Verify';

  @override
  String get savePassword => 'Save New Password';
}
