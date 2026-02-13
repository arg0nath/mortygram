import 'package:equatable/equatable.dart';

//removed ApiException cause i did it w/ dio
class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => <Object?>[message, statusCode];
}

class ApiException extends Equatable implements Exception {
  const ApiException({
    required this.message,
    required this.statusCode,
    this.data,
  });

  final String message;
  final String? data;
  final int statusCode;

  @override
  List<Object?> get props => <Object?>[message, data, statusCode];
}
