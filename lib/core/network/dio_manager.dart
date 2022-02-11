import 'package:dio/dio.dart';
import 'package:nytbooks/core/network/interceptors/dio_logging_interceptor.dart';

class ApiManager {
  final _connectTimeout = 2000;
  final _receiveTimeout = 2000;

  late Dio dio;

  ApiManager() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://api.nytimes.com/svc/books',
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json);

    dio = Dio(options);

    dio.interceptors.add(DioLoggingInterceptor());
  }
}
