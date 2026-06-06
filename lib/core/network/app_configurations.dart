import 'network_config.dart';

class AppConfiguration {
  String get apiBaseURL {
    switch (ApiDataNetworkConfig.networkEnvironment) {
      case NetworkEnvironment.dev: return "https://api.saaei.co";
      case NetworkEnvironment.production: return "https://api.saaei.co";
      case NetworkEnvironment.stage: return "https://api-stg.saaei.co";
    }
  }

  String get imagesBaseURL => "https://api.saaei.co";
  
  String get shareLinksURL {
    switch (ApiDataNetworkConfig.networkEnvironment) {
      case NetworkEnvironment.dev: return "https://api.saaei.co";
      case NetworkEnvironment.production: return "https://saaei.co/";
      case NetworkEnvironment.stage: return "https://frontend-stg.saaei.co/";
    }
  }
}
