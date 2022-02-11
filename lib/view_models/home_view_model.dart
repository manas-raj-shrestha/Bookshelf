import 'dart:collection';

import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/core/services/books_service.dart';

import 'package:nytbooks/view_models/base_model.dart';

class HomeViewModel extends BaseModel {
  BooksService bookApiService = BooksService();

  List<Books> _bestSellingBooks = [];

  List<Books> get bestSellingBooks => UnmodifiableListView(_bestSellingBooks);

  Future fetchBestSellingBooks() async {
    changeState(ViewState.busy);
    _bestSellingBooks = await bookApiService.fetchBestSellingBooks();
    changeState(ViewState.idle);
  }
}
