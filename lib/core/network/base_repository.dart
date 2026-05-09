import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../exceptions/failure.dart';
import '../exceptions/failure_mapper.dart';
import '../services/api_service/api_response.dart';

/// Single canonical entry point for repository → Retrofit/Dio calls.
///
/// All transport-level exceptions are normalized via [FailureMapper] so the
/// rest of the app never has to know about [DioException]. Repositories
/// extending this class return `Future<Either<Failure, T>>`.
abstract class BaseRepository {
  const BaseRepository();

  /// Wraps a single Dio/Retrofit call. Network and parse errors become a
  /// [Left<Failure>]; the awaited value becomes [Right].
  Future<Either<Failure, T>> safeApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      return Right(await apiCall());
    } on DioException catch (e) {
      return Left(FailureMapper.fromDioException(e));
    } catch (e) {
      return Left(FailureMapper.fromError(e));
    }
  }

  /// Same as [safeApiCall] but additionally folds the application-level
  /// `status:false` envelope into a [Failure.server]. Use this for any
  /// endpoint that returns the project's standard [ApiResponse] shape.
  Future<Either<Failure, ApiResponse<T>>> safeApiResponseCall<T>(
    Future<ApiResponse<T>> Function() apiCall,
  ) async {
    final result = await safeApiCall(apiCall);
    return result.fold(
      Left.new,
      (response) => response.status
          ? Right(response)
          : Left(
              Failure.server(code: response.code, message: response.message),
            ),
    );
  }
}
