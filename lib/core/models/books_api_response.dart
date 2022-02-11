class BooksApiResponse {
  List<Books>? books;

  BooksApiResponse({this.books});

  BooksApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['Books'] != null) {
      books = <Books>[];
      json['Books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['Books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  int? id;
  String? title;
  String? author;
  String? imgUrl;
  String? price;
  String? review;
  String? description;
  String? source;

  Books(
      {this.id,
      this.title,
      this.author,
      this.imgUrl,
      this.price,
      this.review,
      this.description,
      this.source});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['imgUrl'] = this.imgUrl;
    data['price'] = this.price;
    data['review'] = this.review;
    data['description'] = this.description;
    data['source'] = this.source;
    return data;
  }
}
