import 'package:nytbooks/core/models/book.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/core/services/book_service.dart';

class BookserviceMock extends BookService {
  @override
  Future<BooksApiResponse> fetchBestSellingBooks() async {
    return Future.value(BooksApiResponse(books: [
      Books(1, 'The Year of the Locust: Terry Hayes', 'Terry Hayes', 'NA',
          '£16.00', '3.2 out of 5 stars', '', ''),
      Books(2, 'Billy Summers: The No. 1 Bestseller', 'Stephen King', 'NA',
          '£20.00', '4 out of 5 stars', '', '')
    ]));
  }
}
