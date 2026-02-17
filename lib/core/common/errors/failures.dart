import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
    : assert(
        statusCode is int || statusCode is String,
        'statusCode must be either an int or a String not a ${statusCode.runtimeType}',
      );

  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode ${statusCode is String ? '' : ' Error'}: $message';

  @override
  List<Object?> get props => <Object?>[message, statusCode];
}

class ApiFailure extends Failure {
  ApiFailure({required super.message, required super.statusCode});

  /// Create ApiFailure from DioException
  factory ApiFailure.fromException(DioException dioException) {
    return ApiFailure(
      message: dioException.message ?? dioException.error?.toString() ?? 'Unknown error occurred',
      statusCode: dioException.response?.statusCode ?? 500,
    );
  }
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, required super.statusCode});
}
