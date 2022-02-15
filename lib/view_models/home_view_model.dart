import 'dart:collection';

import '../core/enums/view_states.dart';

import '../core/models/book.dart';

import '../core/services/book_service.dart';
import '../core/services/local_storage_service.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  final LocalStorageService _localStorageService;
  final BookService _bookApiService;

  final List<Books> _books = [];

  List<Books> get books => UnmodifiableListView(_books);

  HomeViewModel(this._localStorageService, this._bookApiService);

  Future fetchBooks() async {
    changeState(ViewState.busy);
    var savedBooks = retriveBooksFromStorage();
    try {
      if (savedBooks.isNotEmpty) {
        _books.addAll(savedBooks);
        changeState(ViewState.idle);
      }

      var booksApiResponse = await _bookApiService.fetchBestSellingBooks();

      _books.clear();
      _books.addAll(booksApiResponse.books ?? []);

      _saveToLocalStorage(booksApiResponse);

      changeState(ViewState.idle);
    } catch (e) {
      //Change state to error only if there are no cached books
      if (savedBooks.isEmpty) changeState(ViewState.error);
    }
  }

  void _saveToLocalStorage(booksApiResponse) {
    _localStorageService.addBookRespose(booksApiResponse);
  }

  List<Books> retriveBooksFromStorage() {
    return _localStorageService.getBooksResponse();
  }
}
