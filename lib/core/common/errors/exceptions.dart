import 'package:equatable/equatable.dart';

//removed ApiException cause i did it w/ dio
class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => <Object?>[message, statusCode];
}
