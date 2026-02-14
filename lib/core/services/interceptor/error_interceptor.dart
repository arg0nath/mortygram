import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection Timeout';
    } else if (err.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Receive Timeout';
    } else if (err.type == DioExceptionType.badResponse) {
      if (err.response?.statusCode == 429) {
        errorMessage = "You're sending requests too fast. Try again shortly.";
      } else {
        errorMessage = 'Received invalid status code: ${err.response?.statusCode}';
      }
    } else if (err.type == DioExceptionType.connectionError) {
      errorMessage = 'Connection Error. Please check your internet connection.';
    } else {
      errorMessage = 'Something went wrong Morrrty';
    }

    myLog('Error: $errorMessage', level: .error);

    // Reject with modified DioException containing user-friendly message
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: errorMessage,
        message: errorMessage,
      ),
    );
  }
}
