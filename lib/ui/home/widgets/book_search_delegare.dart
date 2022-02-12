import 'package:flutter/material.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookSearchDelegate extends SearchDelegate {
  late List<Books> books;

  BookSearchDelegate(this.books);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchItems = getSearchResult(query);

    if (books.isEmpty && query.isNotEmpty) {
      return const Center(child: Text('No match found'));
    }
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(height: 1);
        },
        padding: EdgeInsets.only(bottom: 108.h),
        itemCount: query.isNotEmpty ? searchItems.length : books.length,
        itemBuilder: (ctx, index) {
          final item = query.isNotEmpty ? searchItems[index] : books[index];
          return ListTile(
            title: Text(
              item.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchItems = getSearchResult(query);

    if (books.isEmpty && query.isNotEmpty) {
      return const Center(child: Text('No match found'));
    }

    return ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(height: 1);
        },
        padding: EdgeInsets.only(bottom: 108.h),
        itemCount: query.isNotEmpty ? searchItems.length : books.length,
        itemBuilder: (ctx, index) {
          final item = query.isNotEmpty ? searchItems[index] : books[index];
          return ListTile(
            title: Text(
              item.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        });
  }

  List<Books> getSearchResult(String query) {
    if (query.isNotEmpty) {
      return books.where((option) {
        var title = option.title ?? '';
        return title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    return [];
  }
}
