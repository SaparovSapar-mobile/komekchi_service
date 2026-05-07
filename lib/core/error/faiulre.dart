import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => '$runtimeType: $message';

  static Failure fromException(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return const NetworkFailure(message: "Connection timed out");
      } else if (error.type == DioExceptionType.badResponse) {
        return ServerFailure(
          message: error.response?.data?['message'] ??
              'Server error occurred',
          code: error.response?.statusCode,
        );
      } else if (error.type == DioExceptionType.connectionError) {
        return const NetworkFailure(message: "No internet connection");
      } else if (error.type == DioExceptionType.cancel) {
        return const DownloadFailure(message: "Download cancelled");
      } else {
        return const UnknownFailure(message: "Unexpected network error");
      }
    } else if (error is FormatException) {
      return const ParsingFailure(message: "Data parsing error");
    } else if (error is DownloadException) {
      return DownloadFailure(message: error.message);
    } else if (error is NotificationException) {
      return NotificationFailure(message: error.message);
    } else if (error is UnauthorizedFailure) {
      return error;
    } else {
      return UnknownFailure(message: error.toString());
    }
  }
}

//////////////////////////
/// ОШИБКИ
//////////////////////////

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

class ParsingFailure extends Failure {
  const ParsingFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}

/// 🔽 НОВОЕ: ошибки скачивания
class DownloadFailure extends Failure {
  const DownloadFailure({required super.message, super.code});
}

/// 🔽 НОВОЕ: ошибки уведомлений
class NotificationFailure extends Failure {
  const NotificationFailure({required super.message, super.code});
}

//////////////////////////
/// EXCEPTIONS
//////////////////////////

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

/// 🔽 Exception для скачивания
class DownloadException implements Exception {
  final String message;
  DownloadException(this.message);
}

/// 🔽 Exception для уведомлений
class NotificationException implements Exception {
  final String message;
  NotificationException(this.message);
}
