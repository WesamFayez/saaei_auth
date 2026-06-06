import 'package:dio/dio.dart';
import 'endpoint.dart';
import 'network_config.dart';
import '../utils/auth_manager.dart';

abstract class NetworkService {
  Future<Response> request(Requestable endpoint, NetworkConfigurable config);
}

class DefaultNetworkService implements NetworkService {
  final Dio _dio;

  DefaultNetworkService(this._dio);

  @override
  Future<Response> request(Requestable endpoint, NetworkConfigurable config) async {
    final String url = endpoint.isFullPath
        ? endpoint.path
        : "${config.baseURL}/${endpoint.path}";

    final Map<String, dynamic> headers = Map.from(config.headers);
    headers.addAll(endpoint.headerParameters);

    if (endpoint.isAuthenticate) {
      final token = AuthManager.shared.token;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
      }
    }

    final Options options = Options(
      method: endpoint.method.value,
      headers: headers,
    );

    dynamic data = endpoint.bodyParameters;
    if (endpoint.files != null && endpoint.files!.isNotEmpty) {
      final Map<String, dynamic> formDataMap = Map.from(endpoint.bodyParameters);
      for (var attachment in endpoint.files!) {
        if (attachment.file != null) {
          formDataMap[attachment.fieldName] = MultipartFile.fromBytes(
            attachment.file!,
            filename: attachment.fileName,
          );
        } else if (attachment.filePath != null) {
          formDataMap[attachment.fieldName] = await MultipartFile.fromFile(
            attachment.filePath!,
            filename: attachment.fileName,
          );
        }
      }
      data = FormData.fromMap(formDataMap);
    }

    return _dio.request(
      url,
      data: data,
      queryParameters: endpoint.queryParameters,
      options: options,
    );
  }
}
