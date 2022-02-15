import '../helper/dependency_injection.dart';

import '../models/books_api_response.dart';
import '../network/dio_manager.dart';

class BookService {
  Future<BooksApiResponse> fetchBooks() async {
    var response = await serviceLocator<ApiManager>().dio.get('/books');

    BooksApiResponse booksApiResponse =
        BooksApiResponse.fromJson(response.data);

    return booksApiResponse;
  }
}
