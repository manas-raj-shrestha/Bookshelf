import 'package:hive_flutter/hive_flutter.dart';
import '../models/book.dart';
import '../models/books_api_response.dart';

class LocalStorageService {
  Future addBookRespose(BooksApiResponse booksApiResponse) async {
    Box localBox = Hive.box<Book>('books');

    if (localBox.keys.isNotEmpty) await localBox.clear();

    await localBox.addAll(booksApiResponse.books!);
  }

  List<Book> getBooksResponse() {
    Box localBox = Hive.box<Book>('books');
    List<Book> books = List.from(localBox.values);
    return books;
  }
}
