import 'package:dio/dio.dart';
import 'package:nytbooks/core/network/interceptors/dio_auth_interceptor.dart';
import 'package:nytbooks/core/network/interceptors/dio_logging_interceptor.dart';

class ApiManager {
  final _connectTimeout = 4000;
  final _receiveTimeout = 4000;

  late Dio dio;

  ApiManager() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://bookshelves.p.rapidapi.com',
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json);

    dio = Dio(options);

    dio.interceptors.addAll([DioAuthInterceptor()]);
  }
}
