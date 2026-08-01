import 'package:dio/dio.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/core/error/failure.dart';

/// Shared by every remote data source: runs [request], accepts the response
/// only if its status code is in [successCodes], parses it with [onSuccess] —
/// otherwise (or on any thrown error) surfaces a [Failure].
abstract class BaseRemoteDataSource {
  final ApiService api;

  const BaseRemoteDataSource({required this.api});

  Future<T> handle<T>(
    Future<Response> Function() request,
    T Function(dynamic data) onSuccess, {
    required String errorMessage,
    Set<int> successCodes = const {200},
  }) async {
    try {
      final response = await request();
      if (successCodes.contains(response.statusCode)) {
        return onSuccess(response.data);
      }
      throw ServerFailure(message: errorMessage, code: response.statusCode);
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  /// Same as [handle] for endpoints whose success response carries nothing
  /// worth parsing.
  Future<void> handleVoid(
    Future<Response> Function() request, {
    required String errorMessage,
    Set<int> successCodes = const {200},
  }) {
    return handle(
      request,
      (_) {},
      errorMessage: errorMessage,
      successCodes: successCodes,
    );
  }
}
