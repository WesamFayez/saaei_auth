import 'package:dio/dio.dart';
import 'endpoint.dart';
import 'network_config.dart';
import 'network_service.dart';
import 'network_logger.dart';
import '../error/base_error.dart';

abstract class DataTransferService {
  Future<T> request<T>(ResponseRequestable<T> endpoint, T Function(dynamic) fromJson);
}

class DefaultDataTransferService implements DataTransferService {
  final NetworkService _networkService;
  final NetworkConfigurable _config;


  static final DataTransferService apiManager = _createApiManager();

  static DataTransferService _createApiManager() {
    final dio = Dio();

    dio.interceptors.add(NetworkLogger());

    return DefaultDataTransferService(
      DefaultNetworkService(dio),
      ApiDataNetworkConfig(baseURL: ApiDataNetworkConfig.resource),
    );
  }

  DefaultDataTransferService(this._networkService, this._config);

  @override
  Future<T> request<T>(ResponseRequestable<T> endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await _networkService.request(endpoint, _config);


      final dynamic responseData = response.data;

      return fromJson(responseData);

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw NetworkConnectionError(message: "The request timed out.");
      } else if (e.response?.statusCode == 401) {
        throw AuthError(message: "The request requires user authentication.");
      } else {
        String? serverMessage;
        if (e.response?.data != null && e.response?.data is Map) {
          final data = e.response?.data as Map;

          if (data.containsKey('errors') && data['errors'] is List && (data['errors'] as List).isNotEmpty) {
            final firstError = data['errors'][0];
            if (firstError is Map && firstError.containsKey('msg')) {
              serverMessage = firstError['msg'];
            }
          } else if (data.containsKey('message')) {
            serverMessage = data['message'];
          }
        }

        throw ServerError(
          statusCode: e.response?.statusCode ?? 0,
          message: serverMessage ?? e.response?.statusMessage ?? "Seems server is down",
        );
      }
    } catch (e) {
      if (e is BaseError) rethrow;
      throw OtherError(message: e.toString());
    }
  }
}
