import 'package:flutter_test/flutter_test.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/view_models/home_view_model.dart';

import 'mocks/mock_book_service.dart';
import 'mocks/mock_local_storage.dart';

void main() {
  group('Home view model logic test', () {
    setupInjections();

    HomeViewModel homeViewModel =
        HomeViewModel(MockLocalStorage(), BookserviceMock());

    test('When Fetched Books, Then Return Correct Length', () async {
      await homeViewModel.fetchBooks();
      expect(homeViewModel.books.length, 2);
    });
  });
}
