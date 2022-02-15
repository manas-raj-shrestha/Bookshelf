import 'package:hive/hive.dart';

import 'book.dart';

class BooksApiResponse extends HiveObject {
  List<Book>? books = [];

  BooksApiResponse({this.books});

  BooksApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['Books'] != null) {
      books = <Book>[];
      json['Books'].forEach((v) {
        books!.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['Books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
