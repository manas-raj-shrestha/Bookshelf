import 'package:dio/dio.dart';
import '../environment.dart';
import 'interceptors/dio_auth_interceptor.dart';

class ApiManager {
  final _connectTimeout = 4000;
  final _receiveTimeout = 4000;

  late Dio dio;

  ApiManager() {
    BaseOptions options = BaseOptions(
        baseUrl: Environment.baseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json);

    dio = Dio(options);

    dio.interceptors.addAll([DioAuthInterceptor()]);
  }
}
