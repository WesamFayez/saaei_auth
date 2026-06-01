import 'dart:async';
import 'package:flutter/foundation.dart';
import '../infrastructure/network/data_transfer_service.dart';
import '../infrastructure/network/network_service.dart';
import '../infrastructure/network/network_config.dart';
import 'package:dio/dio.dart';
import 'base_loading.dart';
import 'base_error.dart';

abstract class BaseViewModelProtocol {
  StreamController<BaseError> get alertMessage;
  StreamController<BaseLoading> get isLoaderHidden;
}

class BaseViewModel extends ChangeNotifier implements BaseViewModelProtocol {
  
  // محاكاة لـ apiManager في سويفت
  late final DataTransferService apiManager;

  // استخدام StreamController لمحاكاة PublishSubject في RxSwift
  @override
  final StreamController<BaseError> alertMessage = StreamController<BaseError>.broadcast();
  
  @override
  final StreamController<BaseLoading> isLoaderHidden = StreamController<BaseLoading>.broadcast();

  BaseViewModel() {
    // إعداد الـ Core Network (المحرك)
    final dio = Dio();
    final networkService = DefaultNetworkService(dio);
    // استخدام الـ config الافتراضي
    final config = ApiDataNetworkConfig(baseURL: ApiDataNetworkConfig.resource);
    
    apiManager = DefaultDataTransferService(networkService, config);
  }

  @override
  void dispose() {
    alertMessage.close();
    isLoaderHidden.close();
    super.dispose();
  }

  // معالجة الأخطاء كما في سويفت
  void handleError(BaseError error) {
    isLoaderHidden.add(BaseLoading.hide);
    alertMessage.add(error);
  }
}
