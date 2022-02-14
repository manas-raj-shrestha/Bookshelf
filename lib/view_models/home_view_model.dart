import 'dart:collection';

import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/book.dart';

import 'package:nytbooks/core/services/book_service.dart';
import 'package:nytbooks/core/services/local_storage_service.dart';

import 'package:nytbooks/view_models/base_model.dart';

class HomeViewModel extends BaseModel {
  final LocalStorageService _localStorageService =
      serviceLocator<LocalStorageService>();
  final BookService _bookApiService = BookService();

  final List<Books> _books = [];

  List<Books> get books => UnmodifiableListView(_books);

  Future fetchBooks() async {
    changeState(ViewState.busy);
    try {
      var booksApiResponse = await _bookApiService.fetchBestSellingBooks();

      _books.addAll(booksApiResponse.books ?? []);
      _saveToLocalStorage(booksApiResponse);

      changeState(ViewState.idle);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

  void _saveToLocalStorage(booksApiResponse) {
    _localStorageService.addBookRespose(booksApiResponse);
  }

  List<Books> retriveBooksFromStorage() {
    return _localStorageService.getBooksResponse();
  }
}
