import 'package:dio/dio.dart';
import 'package:mortygram/config/logger/my_log.dart';

class LoggingInterceptor extends Interceptor {
  /// onRequest: This method is called before a request is sent.
  /// We log the HTTP method (GET, POST, etc.) and the request path.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    myLog('🚀 REQUEST[${options.method}] => Path: ${options.path}', level: .warning);
    myLog('🚀 REQUEST[${options.method}] => Query Params: /${options.queryParameters}', level: .warning);
    myLog('🚀 REQUEST[${options.method}] => Data: ${options.data}', level: .warning);

    // Continue with the request.
    super.onRequest(options, handler);
  }

  /// onResponse: This method is called when a response is received.
  /// We log the status code and the request path.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log the response status code and path.
    myLog('📩 RESPONSE STATUS CODE: [${response.statusCode}]');
    // Continue with the response.
    super.onResponse(response, handler);
  }

  /// onError: This method is called when an error occurs.
  /// We log the error status code (if available) and the request path.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the error status code and path.
    myLog('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}', level: .error);
    // Continue with the error.
    super.onError(err, handler);
  }
}
