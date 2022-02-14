import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Books extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String author;

  @HiveField(3)
  late String imgUrl;

  @HiveField(4)
  late String price;

  @HiveField(5)
  late String review;

  @HiveField(6)
  late String description;

  @HiveField(7)
  late String source;

  Books(this.id, this.title, this.author, this.imgUrl, this.price, this.review,
      this.description, this.source);

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    author = json['author'] ?? '';
    imgUrl = json['imgUrl'] ?? '';
    price = json['price'] ?? '';
    review = json['review'] ?? '';
    description = json['description'] ?? '';
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
