import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/env/env.dart';
import '../../../../core/services/api_service/api_response.dart';
import '../models/login_response_dto.dart';

part 'auth_api.g.dart';

/// Per-feature Retrofit interface for the auth surface. Replaces the legacy
/// monolithic transport interface. Future features (`profile`,
/// `notifications`, …) each get their own `*_api.dart` under
/// `data/datasources/`.
@RestApi(baseUrl: Env.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('auth/login')
  Future<ApiResponse<LoginResponseDto>> login({
    @Body() Map<String, dynamic> jsonBody = const {},
  });

  @POST('auth/register')
  Future<ApiResponse<LoginResponseDto>> signUp({
    @Body() Map<String, dynamic> jsonBody = const {},
  });

  @POST('auth/forgot-password')
  Future<ApiResponse<dynamic>> forgotPassword({
    @Body() Map<String, dynamic> jsonBody = const {},
  });

  @POST('auth/verify-otp')
  Future<ApiResponse<dynamic>> verifyOtp({
    @Body() Map<String, dynamic> jsonBody = const {},
  });

  @GET('logout')
  Future<ApiResponse<dynamic>> logout();
}
