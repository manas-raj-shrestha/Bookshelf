import 'package:flutter_test/flutter_test.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/ui/home/widgets/book_search_delegare.dart';

void main() {
  group('Search Deletegate Logic Test', () {
    setupInjections();

    List<Books> books = [];

    books.add(Books(1, 'The Year of the Locust: Terry Hayes', 'Terry Hayes',
        'NA', '£16.00', '3.2 out of 5 stars', '', ''));
    books.add(Books(2, 'Billy Summers: The No. 1 Bestseller', 'Stephen King',
        'NA', '£20.00', '4 out of 5 stars', '', ''));

    test('Given Matching Query, When Searched, Then Return Correct Length', () {
      BookSearchDelegate bookSearchDelegate = BookSearchDelegate(books);

      expect(bookSearchDelegate.books.length, 2);
      expect(bookSearchDelegate.getSearchResult('Locust').length, 1);
    });

    test('Given Matching Query, When Searched, Then Return Correct Length', () {
      BookSearchDelegate bookSearchDelegate = BookSearchDelegate(books);

      expect(bookSearchDelegate.books.length, 2);
      expect(bookSearchDelegate.getSearchResult('Summers').length, 1);
    });

    test('Given Unmatched Query, When Searched, Then Return Correct Length',
        () {
      BookSearchDelegate bookSearchDelegate = BookSearchDelegate(books);

      expect(bookSearchDelegate.books.length, 2);
      expect(bookSearchDelegate.getSearchResult('Beautiful').length, 0);
    });

    test('Given Empty Query, When Searched, Then Return Empty List', () {
      BookSearchDelegate bookSearchDelegate = BookSearchDelegate(books);

      expect(bookSearchDelegate.books.length, 2);
      expect(bookSearchDelegate.getSearchResult('').length, 0);
    });
  });
}
