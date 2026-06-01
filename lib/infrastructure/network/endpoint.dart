import 'attachment.dart';

enum HTTPMethodType { get, head, post, put, patch, delete }

extension HTTPMethodTypeExtension on HTTPMethodType {
  String get value => name.toUpperCase();
}

enum BodyEncoding { jsonSerializationData, stringEncodingAscii }

abstract class Requestable {
  String get path;
  bool get isFullPath;
  bool get isAuthenticate;
  HTTPMethodType get method;
  Map<String, String> get headerParameters;
  Map<String, dynamic> get queryParameters;
  Map<String, dynamic> get bodyParameters;
  BodyEncoding get bodyEncoding;
  List<Attachment>? get files;
  bool get arrayEncoded;
}

abstract class ResponseRequestable<T> extends Requestable {
  // In Flutter/Dart we usually handle decoding in the service or via a factory
}

class Endpoint<T> implements ResponseRequestable<T> {
  @override
  final String path;
  @override
  final bool isFullPath;
  @override
  final bool isAuthenticate;
  @override
  final HTTPMethodType method;
  @override
  final Map<String, String> headerParameters;
  @override
  final Map<String, dynamic> queryParameters;
  @override
  final Map<String, dynamic> bodyParameters;
  @override
  final BodyEncoding bodyEncoding;
  @override
  final List<Attachment>? files;
  @override
  final bool arrayEncoded;

  Endpoint({
    required this.path,
    this.isFullPath = false,
    this.isAuthenticate = false,
    required this.method,
    this.headerParameters = const {},
    this.queryParameters = const {},
    this.bodyParameters = const {},
    this.files,
    this.bodyEncoding = BodyEncoding.jsonSerializationData,
    this.arrayEncoded = false,
  });
}
