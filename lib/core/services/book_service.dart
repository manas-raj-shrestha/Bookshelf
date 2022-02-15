import 'package:dio/dio.dart';
import '../helper/dependency_injection.dart';

import '../models/books_api_response.dart';
import '../network/dio_manager.dart';

class BookService {
  Future<BooksApiResponse> fetchBestSellingBooks() async {
    var response = await serviceLocator<ApiManager>().dio.get('/books');

    BooksApiResponse booksApiResponse =
        BooksApiResponse.fromJson(response.data);

    return booksApiResponse;
  }
}
