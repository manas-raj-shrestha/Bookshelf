import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/dependency_injection.dart';
import '../../../core/models/book.dart';
import '../../../core/services/local_storage_service.dart';
import '../../detail/book_detail.dart';

class BookSearchDelegate extends SearchDelegate {
  LocalStorageService storageService = serviceLocator<LocalStorageService>();

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
    return _buildResultAndSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResultAndSuggestions(context);
  }

  List<Book> getSearchResult(String query, List<Book> books) {
    if (query.isNotEmpty) {
      return books.where((option) {
        var title = option.title;
        return title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    return [];
  }

  Widget _buildResultAndSuggestions(context) {
    var books = storageService.getBooksResponse();
    final searchItems = getSearchResult(query, books);
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
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BookDetail(item);
              }));
            },
            child: ListTile(
              title: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        });
  }
}
