enum BaseLoading {
  show,
  hide,
  withText,
  uploadWithText,
  showSkeleton,
  hideSkeleton,
}


class LoadingState {
  final BaseLoading type;
  final String? text;

  LoadingState(this.type, {this.text});
}
