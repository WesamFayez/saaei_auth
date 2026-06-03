class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'يرجى كتابة رقم الجوال';
    if (value.length < 9) return 'رقم الجوال غير صحيح';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'يرجى كتابة كلمة المرور';
    if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) return 'يرجى كتابة $fieldName';
    return null;
  }
}


String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value.trim())) {
    return 'Enter a valid email address';
  }

  return null;
}

String? strongPasswordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Password is required';
  }

  if (value.length < 8) {
    return 'Password must be at least 8\ncharacters long';
  }

  final hasUppercase = RegExp(r'[A-Z]');
  final hasLowercase = RegExp(r'[a-z]');
  final hasDigit = RegExp(r'\d');
  final hasSpecialChar = RegExp(r'[!@#\$&*~]');

  if (!hasUppercase.hasMatch(value)) {
    return 'Password must contain at least one\nuppercase letter';
  }

  if (!hasLowercase.hasMatch(value)) {
    return 'Password must contain at least one\nlowercase letter';
  }

  if (!hasDigit.hasMatch(value)) {
    return 'Password must contain at least one\nnumber';
  }

  if (!hasSpecialChar.hasMatch(value)) {
    return 'Password must contain at least\n one special character (!@#\$&*~)';
  }

  return null;
}

String? confirmPasswordValidator(String? value, String originalPassword) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }

  if (value != originalPassword) {
    return 'Passwords do not match';
  }

  return null;
}
