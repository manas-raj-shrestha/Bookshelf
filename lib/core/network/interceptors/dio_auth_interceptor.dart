import 'package:dio/dio.dart';

class DioAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'x-rapidapi-host': 'bookshelves.p.rapidapi.com',
      'x-rapidapi-key': '7a7a83ab8cmsh51f209a871c8f68p1b5390jsn95c7b3c72a78'
    });

    return super.onRequest(options, handler);
  }
}
