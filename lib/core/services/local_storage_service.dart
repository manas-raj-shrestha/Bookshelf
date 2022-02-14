import 'package:hive_flutter/hive_flutter.dart';
import 'package:nytbooks/core/models/book.dart';
import 'package:nytbooks/core/models/books_api_response.dart';

class LocalStorageService {
  Future addBookRespose(BooksApiResponse booksApiResponse) async {
    Box localBox = Hive.box<Books>('books');

    if (localBox.keys.isNotEmpty) await localBox.clear();

    await localBox.addAll(booksApiResponse.books!);
  }

  List<Books> getBooksResponse() {
    Box localBox = Hive.box<Books>('books');
    List<Books> books = List.from(localBox.values);
    return books;
  }
}
