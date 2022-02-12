import 'package:dio/dio.dart';
import 'package:nytbooks/core/environment.dart';

class DioAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'x-rapidapi-host': Environment.apiHost,
      'x-rapidapi-key': Environment.apiKey
    });

    return super.onRequest(options, handler);
  }
}
