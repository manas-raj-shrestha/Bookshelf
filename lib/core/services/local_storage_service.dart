import 'package:hive_flutter/hive_flutter.dart';
import 'package:nytbooks/core/models/books_api_response.dart';

class LocalStorageService {
  Future addBookRespose(BooksApiResponse booksApiResponse) async {
    Box localBox = Hive.box<BooksApiResponse>('books');
    await localBox.clear();
    await localBox.add(booksApiResponse);
  }

  BooksApiResponse? getBooksResponse() {
    Box localBox = Hive.box<BooksApiResponse>('books');
    return localBox.getAt(0);
  }
}
