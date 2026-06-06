abstract class BaseError implements Exception {
  final String? title;
  final String? message;
  BaseError({this.title, this.message});

  @override
  String toString() => message ?? "Unknown Error";
}

class AuthError extends BaseError {
  AuthError({super.title, super.message});
}

class ParsingError extends BaseError {
  ParsingError({super.title, super.message});
}

class NetworkConnectionError extends BaseError {
  NetworkConnectionError({super.title, super.message});
}

class ServerError extends BaseError {
  final int statusCode;
  ServerError({required this.statusCode, super.title, super.message});

  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isServerDown => statusCode >= 500;
}

class OtherError extends BaseError {
  OtherError({super.title, super.message});
}
