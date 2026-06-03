extension SafeUtils on Object? {
  bool get isNotNullOrEmpty {
    final value = this;

    if (value == null) return false;

    if (value is String) return value.isNotEmpty;
    if (value is List) return value.isNotEmpty;

    return true;
  }
}
