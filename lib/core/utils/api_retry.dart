Future<T> retryWithBackoff<T>(
    Future<T> Function() request, {
      int maxRetries = 3,
      Duration initialDelay = const Duration(milliseconds: 500),
    }) async {
  int retries = 0;
  Duration delay = initialDelay;

  while (true) {
    try {
      return await request();
    } catch (e) {
      retries++;
      if (retries > maxRetries) rethrow;

      // Wait before retrying
      await Future.delayed(delay);

      // Exponential backoff
      delay *= 2;
    }
  }
}
