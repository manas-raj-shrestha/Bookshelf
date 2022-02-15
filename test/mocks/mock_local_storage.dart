import 'package:nytbooks/core/models/book.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/core/services/local_storage_service.dart';

class MockLocalStorage extends LocalStorageService {
  @override
  List<Book> getBooksResponse() {
    return [
      Book(1, 'The Year of the Locust: Terry Hayes', 'Terry Hayes', 'NA',
          '£16.00', '3.2 out of 5 stars', '', ''),
      Book(2, 'Billy Summers: The No. 1 Bestseller', 'Stephen King', 'NA',
          '£20.00', '4 out of 5 stars', '', '')
    ];
  }

  @override
  Future addBookRespose(BooksApiResponse booksApiResponse) async {}
}
