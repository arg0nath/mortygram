import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mortygram/config/logger/my_log.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'errors.connectionTimeout'.tr();
    } else if (err.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'errors.receiveTimeout'.tr();
    } else if (err.type == DioExceptionType.badResponse) {
      if (err.response?.statusCode == 429) {
        errorMessage = 'errors.tooManyRequests'.tr();
      } else {
        errorMessage = 'errors.invalidStatusCode'.tr(namedArgs: <String, String>{'code': '${err.response?.statusCode}'});
      }
    } else if (err.type == DioExceptionType.connectionError) {
      errorMessage = 'errors.connectionError'.tr();
    } else {
      errorMessage = 'errors.somethingWentWrong'.tr();
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
