enum NetworkEnvironment { dev, production, stage }

abstract class NetworkConfigurable {
  String get baseURL;
  Map<String, String> get headers;
  Map<String, String> get queryParameters;
}

class ApiDataNetworkConfig implements NetworkConfigurable {
  @override
  final String baseURL;
  @override
  final Map<String, String> headers;
  @override
  final Map<String, String> queryParameters;

  static NetworkEnvironment networkEnvironment = NetworkEnvironment.stage;

  static String get resource {
    switch (networkEnvironment) {
      case NetworkEnvironment.dev: return "https://api.saaei.co";
      case NetworkEnvironment.production: return "https://api.saaei.co";
      case NetworkEnvironment.stage: return "https://api-stg.saaei.co";
    }
  }

  ApiDataNetworkConfig({
    required this.baseURL,
    this.headers = const {
      "Content-Type": "application/json",
      "device-type": "android",
      "Accept-Language": "ar",
      "language":"ar",
      "Accept": "application/json",
    },
    this.queryParameters = const {},
  });
}
