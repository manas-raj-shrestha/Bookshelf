import 'package:flutter_test/flutter_test.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/book.dart';

import 'package:nytbooks/core/services/local_storage_service.dart';
import 'package:nytbooks/ui/home/widgets/book_search_delegare.dart';

class MockLocalStorage extends LocalStorageService {
  @override
  List<Books> getBooksResponse() {
    return [
      Books(1, 'The Year of the Locust: Terry Hayes', 'Terry Hayes', 'NA',
          '£16.00', '3.2 out of 5 stars', '', ''),
      Books(2, 'Billy Summers: The No. 1 Bestseller', 'Stephen King', 'NA',
          '£20.00', '4 out of 5 stars', '', '')
    ];
  }
}

void main() {
  group('Search Deletegate Logic Test', () {
    setupInjections();

    BookSearchDelegate bookSearchDelegate = BookSearchDelegate();
    bookSearchDelegate.storageService = MockLocalStorage();

    var books = bookSearchDelegate.storageService.getBooksResponse();

    test('Given Matching Query, When Searched, Then Return Correct Length', () {
      expect(bookSearchDelegate.getSearchResult('Locust', books).length, 1);
    });

    test('Given Matching Query, When Searched, Then Return Correct Length', () {
      expect(bookSearchDelegate.getSearchResult('Summers', books).length, 1);
    });

    test('Given Unmatched Query, When Searched, Then Return Correct Length',
        () {
      expect(bookSearchDelegate.getSearchResult('Beautiful', books).length, 0);
    });

    test('Given Empty Query, When Searched, Then Return Empty List', () {
      expect(bookSearchDelegate.getSearchResult('', books).length, 0);
    });
  });
}
