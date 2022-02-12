import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class BooksApiResponse extends HiveObject {
  @HiveField(0)
  List<Books>? books;

  BooksApiResponse({books});

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

@HiveType(typeId: 2)
class Books extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? imgUrl;

  @HiveField(4)
  String? price;

  @HiveField(5)
  String? review;

  @HiveField(6)
  String? description;

  @HiveField(7)
  String? source;

  Books(id, title, author, imgUrl, price, review, description, source);

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    imgUrl = json['imgUrl'];
    price = json['price'];
    review = json['review'];
    description = json['description'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['imgUrl'] = imgUrl;
    data['price'] = price;
    data['review'] = review;
    data['description'] = description;
    data['source'] = source;
    return data;
  }
}
