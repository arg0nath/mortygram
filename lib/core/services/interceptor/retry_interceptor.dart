import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/core/common/constants/app_const.dart';

class RetryInterceptor extends Interceptor {
  const RetryInterceptor(this.dio);
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final RequestOptions options = err.requestOptions;

    // Add retry limit
    if (options.extra['retryCount'] == null) {
      options.extra['retryCount'] = 0;
    }

    if ((options.extra['retryCount'] as int) < AppConst.retryMaxAttempts && _shouldRetry(err)) {
      options.extra['retryCount'] += 1;

      try {
        final Response<dynamic> response = await dio.fetch(options);

        return handler.resolve(response);
      } catch (e) {
        myLog('Retry failed: $e', level: .error);
        return handler.next(err);
      }
    } else {
      myLog('Retry limit reached or not retryable. Returning original error.', level: .warning);
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException exception) {
    return exception.type == DioExceptionType.connectionError || exception.type == DioExceptionType.badResponse;
  }
}
