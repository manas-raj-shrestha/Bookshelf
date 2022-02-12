import 'dart:collection';

import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/core/services/book_service.dart';

import 'package:nytbooks/view_models/base_model.dart';

class HomeViewModel extends BaseModel {
  BookService bookApiService = BookService();

  List<Books> _books = [];

  List<Books> get books => UnmodifiableListView(_books);

  Future fetchBestSellingBooks() async {
    changeState(ViewState.busy);
    try {
      _books = await bookApiService.fetchBestSellingBooks();
      _saveToLocalStorage();
      changeState(ViewState.idle);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

  void _saveToLocalStorage() {}
}
