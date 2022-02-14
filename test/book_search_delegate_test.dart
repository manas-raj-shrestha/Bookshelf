import 'package:flutter_test/flutter_test.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/ui/home/widgets/book_search_delegate.dart';

import 'mocks/mock_local_storage.dart';

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
