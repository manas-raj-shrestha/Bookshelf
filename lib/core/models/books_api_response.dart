import 'package:hive/hive.dart';

import 'book.dart';

class BooksApiResponse extends HiveObject {
  List<Books>? books = [];

  BooksApiResponse({this.books});

  BooksApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['Books'] != null) {
      books = <Books>[];
      json['Books'].forEach((v) {
        books!.add(Books.fromJson(v));
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
