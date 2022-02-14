import 'dart:collection';

import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/book.dart';

import 'package:nytbooks/core/services/book_service.dart';
import 'package:nytbooks/core/services/local_storage_service.dart';

import 'package:nytbooks/view_models/base_model.dart';

class HomeViewModel extends BaseModel {
  LocalStorageService localStorageService =
      serviceLocator<LocalStorageService>();
  BookService bookApiService = BookService();

  final List<Books> _books = [];

  List<Books> get books => UnmodifiableListView(_books);

  HomeViewModel(this.localStorageService, this.bookApiService);

  Future fetchBooks() async {
    changeState(ViewState.busy);
    try {
      var booksApiResponse = await bookApiService.fetchBestSellingBooks();

      _books.addAll(booksApiResponse.books ?? []);
      _saveToLocalStorage(booksApiResponse);

      changeState(ViewState.idle);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

  void _saveToLocalStorage(booksApiResponse) {
    localStorageService.addBookRespose(booksApiResponse);
  }

  List<Books> retriveBooksFromStorage() {
    return localStorageService.getBooksResponse();
  }
}
