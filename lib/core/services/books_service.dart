import 'package:dio/dio.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/core/network/dio_manager.dart';

class BooksService {
  Dio dioInstance = serviceLocator<ApiManager>().dio;

  Future<List<Books>> fetchBestSellingBooks() async {
    var response = await dioInstance.get('/books');

    BooksApiResponse booksApiResponse =
        BooksApiResponse.fromJson(response.data);

    return booksApiResponse.books ?? [];
  }
}
