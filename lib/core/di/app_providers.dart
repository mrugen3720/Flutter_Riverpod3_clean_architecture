import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/connectivity.dart';
import '../network/retry_interceptor.dart';
import '../network/ssl_pinning.dart';
import '../services/api_service/interceptor.dart';
import '../storage/secure_token_storage.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final tokenStorage = ref.watch(secureTokenStorageProvider);
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  )..interceptors.add(
      ApiInterceptors(
        tokenReader: tokenStorage.read,
        connectivityCheck: () => ref.read(connectivityProvider),
      ),
    );
  dio.interceptors.add(RetryInterceptor(dio));
  configureSslPinning(dio);
  return dio;
}
