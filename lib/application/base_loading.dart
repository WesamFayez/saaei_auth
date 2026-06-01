enum BaseLoading {
  show,
  hide,
  withText,
  uploadWithText,
  showSkeleton,
  hideSkeleton,
}

// يمكننا إضافة كلاس لحمل النص إذا لزم الأمر مثلما فعلت في سويفت
class LoadingState {
  final BaseLoading type;
  final String? text;

  LoadingState(this.type, {this.text});
}
